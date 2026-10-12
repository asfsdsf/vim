-- Run from the repository root: nvim --clean --headless -l tests/find_actions.lua
-- Uses only temporary settings and a local HTTP server, never the real provider.
local uv = vim.uv or vim.loop
-- Optionally exercise the installed Markdown renderer and parsers as well.
local markdown_runtime = vim.env.FIND_ACTIONS_TEST_RENDER_RUNTIME
if markdown_runtime then
  vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter")
  vim.opt.runtimepath:prepend(markdown_runtime)
  vim.cmd.source(markdown_runtime .. "/plugin/render-markdown.lua")
end
local assistant = dofile("NvChad/find_actions.lua")
local chat = require("llm_chat")
local commands = dofile("NvChad/find_commands.lua")
local temp = vim.fn.tempname()
vim.fn.mkdir(temp .. "/.ai", "p")
local stdpath, executable, notify = vim.fn.stdpath, vim.fn.executable, vim.notify
local notices, requests, clients = {}, {}, {}
local response = { status = 200, body = { choices = { { message = { content = "# Close a window\n\nUse `<c-w>c`." } } } } }
local held = false
local server = uv.new_tcp()
assert(server:bind("127.0.0.1", 0))
assert(server:listen(16, function(err)
  assert(not err, err)
  local client = uv.new_tcp()
  server:accept(client)
  clients[#clients + 1] = client
  local received, answered = "", false
  client:read_start(function(read_error, data)
    assert(not read_error, read_error)
    if not data then
      if not client:is_closing() then client:close() end
      return
    end
    received = received .. data
    local header, body = received:match("^(.-)\r\n\r\n(.*)$")
    local length = header and tonumber(header:lower():match("content%-length: (%d+)"))
    if answered or not length or #body < length then return end
    answered = true
    local request = { header = header, body = vim.json.decode(body:sub(1, length)) }
    requests[#requests + 1] = request
    if held then return end
    if response.stream then
      client:write("HTTP/1.1 " .. response.status .. " Test\r\nContent-Type: text/event-stream\r\n"
        .. "Transfer-Encoding: chunked\r\nConnection: close\r\n\r\n")
      request.send = function(piece)
        if not client:is_closing() then client:write(string.format("%X\r\n", #piece) .. piece .. "\r\n") end
      end
      request.finish = function()
        client:write("0\r\n\r\n", function()
          client:shutdown(function() if not client:is_closing() then client:close() end end)
        end)
      end
      request.abort = function() if not client:is_closing() then client:close() end end
      return
    end
    local payload = type(response.body) == "string" and response.body or vim.json.encode(response.body)
    client:write("HTTP/1.1 " .. response.status .. " Test\r\nContent-Type: application/json\r\nContent-Length: "
      .. #payload .. "\r\nConnection: close\r\n\r\n" .. payload, function()
      client:shutdown(function() if not client:is_closing() then client:close() end end)
    end)
  end)
end))
local port = server:getsockname().port
local base = "http://127.0.0.1:" .. port .. "/v1"
vim.fn.stdpath = function(kind) return kind == "config" and temp or stdpath(kind) end
vim.notify = function(message) notices[#notices + 1] = message end
local inherited = { vim.env.https_proxy, vim.env.http_proxy, vim.env.BASE_URL, vim.env.API_KEY, vim.env.MODEL }
vim.env.https_proxy = "http://127.0.0.1:1"
vim.env.http_proxy = "http://127.0.0.1:1"
vim.env.BASE_URL, vim.env.API_KEY, vim.env.MODEL = "inherited", "inherited", "inherited"
local reference_file = assert(io.open("vim_tip/find_actions", "rb"))
local reference = reference_file:read("*a")
reference_file:close()
local function check(condition, message) assert(condition, message) end
local function wait(predicate, message)
  check(vim.wait(6000, predicate, 10), message)
end
local function settings(extra, url)
  vim.fn.writefile(vim.split('export BASE_URL="' .. (url or base) .. '"\nexport API_KEY="test-key"\n'
    .. (extra or ""), "\n", { plain = true }), temp .. "/.ai/env")
end
local function text()
  return table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
end
local function answer(question)
  assistant.submit(question or "close window", reference)
  wait(function() return text():find("<c%-w>c") ~= nil end, "answer did not arrive: " .. text())
end
local function notice(fragment)
  for _, message in ipairs(notices) do if message:find(fragment, 1, true) then return true end end
  return false
end
local function error_answer(fragment)
  assistant.submit("close window", reference)
  wait(function() return notice(fragment) end, "expected diagnostic: " .. fragment)
  notices = {}
end
local function rendered_heading()
  if not markdown_runtime then return end
  local namespace = vim.api.nvim_get_namespaces()["render-markdown.nvim"]
  check(namespace ~= nil, "Markdown renderer did not initialize")
  wait(function()
    for _, mark in ipairs(vim.api.nvim_buf_get_extmarks(0, namespace, 0, -1, { details = true })) do
      if mark[2] == 0 and mark[4].virt_text then return true end
    end
    return false
  end, "question heading was not rendered")
end

local function run()
  assistant.setup()
  commands.setup()
  check(vim.fn.exists(":FindActions") == 2, "command missing")
  check(vim.fn.exists(":LLMChat") == 2 and vim.fn.exists(":FindCommands") == 2, "shared chat commands missing")
  check(vim.fn.maparg("<Space>aa", "n") == "<Cmd>FindActions<CR>", "mapping missing")
  check(vim.fn.maparg("<Space><Space>", "n") == "<Cmd>LLMChat<CR>", "general chat mapping missing")
  check(vim.fn.maparg("<Space>:", "n") == "<Cmd>FindCommands<CR>", "command search mapping missing")
  vim.keymap.set("n", "<Space><Space>", ":<C-f>")
  vim.keymap.set("n", "<Space>:", "<Cmd>call VimuxPromptCommand()<CR>")
  wait(function()
    return vim.fn.maparg("<Space><Space>", "n") == "<Cmd>LLMChat<CR>"
      and vim.fn.maparg("<Space>:", "n") == "<Cmd>FindCommands<CR>"
  end, "scheduled starter mappings replaced chat bindings")
  local avante_opts
  package.loaded["avante.config"] = { override = function(opts) avante_opts = opts end }
  vim.keymap.set({ "n", "v" }, "<Space>aa", "<Nop>", { desc = "avante: ask" })
  vim.api.nvim_exec_autocmds("User", { pattern = "LazyLoad", data = "avante.nvim" })
  check(vim.fn.maparg("<Space>aa", "n") == "<Cmd>FindActions<CR>", "Avante replaced search")
  check(vim.fn.maparg("<Space>aa", "x") == "", "Avante visual collision remains")
  check(avante_opts.mappings.ask == "\\aa", "Avante ask not moved")
  package.loaded["avante.config"] = nil

  settings('MODEL="test-model"\nREASONING_EFFORT=xhigh')
  local question = 'How to close "window", show me all keymap $() `x`\n中文'
  answer(question)
  local request = requests[#requests]
  check(request.header:find("POST /v1/chat/completions", 1, true), "wrong endpoint")
  check(request.header:find("Authorization: Bearer test-key", 1, true), "missing auth")
  check(request.body.messages[3].content == question, "query was changed")
  local shown_question, shown_answer = text():match("^## Your question\n\n(.-)\n\n%-%-%-\n\n## Answer\n\n(.*)$")
  check(shown_question == question, "submitted question not preserved above separator")
  check(shown_answer == response.body.choices[1].message.content, "answer not preserved below separator")
  check(request.body.messages[2].content:sub(-#reference) == reference, "reference was truncated")
  check(request.body.messages[1].role == "system", "system prompt missing")
  check(request.body.model == "test-model" and request.body.reasoning_effort == "xhigh", "request settings ignored")
  check(request.body.stream == true, "streaming was not requested")
  check(vim.bo.filetype == "markdown" and vim.bo.buftype == "nofile", "answer isn't Markdown scratch")
  check(not vim.bo.modifiable and vim.wo.wrap, "answer buffer options")
  check(vim.api.nvim_win_get_config(0).relative == "editor", "answer isn't a float")
  rendered_heading()
  vim.api.nvim_exec_autocmds("VimResized", {})
  check(vim.api.nvim_win_get_config(0).width > 0, "resize failed")

  settings('MODEL=""\nREASONING_EFFORT=""')
  answer()
  check(requests[#requests].body.model == "gpt-6-luna", "default model ignored")
  check(requests[#requests].body.reasoning_effort == nil, "empty reasoning effort sent")

  local function start_stream(question)
    response = { status = 200, stream = true }
    local count = #requests
    assistant.submit(question or "stream this question", reference)
    wait(function() return #requests > count and requests[#requests].send ~= nil end, "stream did not start")
    return requests[#requests]
  end
  local function delta(content)
    return 'data: ' .. vim.json.encode({ choices = { { delta = { content = content }, finish_reason = vim.NIL } } }) .. '\r\n\r\n'
  end
  local function title()
    return vim.api.nvim_win_get_config(0).title[1][1]
  end
  local function stream_notice(fragment)
    wait(function() return notice(fragment) end, "expected stream diagnostic: " .. fragment)
    check(title():find("Error", 1, true), "failed stream still appears active")
    notices = {}
  end
  local streaming = start_stream("Show all close-window shortcuts")
  streaming.send(': keepalive\r\n\r\n'
    .. 'data: {"choices":[{"delta":{"role":"assistant"},"finish_reason":null}]}\r\n\r\n'
    .. 'data: {"choices":[{"delta":{"reasoning_content":"Checking window shortcuts."},"finish_reason":null}]}\r\n\r\n')
  wait(function() return text():find("> [!NOTE] Thinking\n> Checking window shortcuts.", 1, true) ~= nil end, "thinking was not streamed before answer")
  check(title():find("Thinking", 1, true), "thinking progress missing")
  check(text():find("*Waiting for the answer…*", 1, true), "thinking was mixed into answer")
  streaming.send('data: ' .. vim.json.encode({ choices = { { delta = {
    reasoning_content = "\n\nCompare modes 中文.", reasoning = "DUPLICATE_ALIAS",
  }, finish_reason = vim.NIL } } }) .. '\r\n\r\n')
  -- Split both a UTF-8 character and the terminating CRLF over curl reads.
  local first = delta("### Close a window 中文")
  local cut = assert(first:find("中", 1, true))
  streaming.send(first:sub(1, cut))
  streaming.send(first:sub(cut + 1, -2))
  streaming.send(first:sub(-1))
  wait(function() return text():find("### Close a window 中文", 1, true) ~= nil end, "first content was not shown before stream completion")
  check(title():find("Streaming", 1, true), "streaming progress missing")
  check(text():find("> Checking window shortcuts.\n> \n> Compare modes 中文.", 1, true), "multiline thinking lost blockquote formatting")
  check(not text():find("DUPLICATE_ALIAS", 1, true), "thinking aliases duplicated")
  rendered_heading()
  vim.api.nvim_win_set_cursor(0, { 2, 0 })
  streaming.send('event: message\r\ndata: {"choices":\r\n'
    .. 'data: [{"delta":{"content":"\\n\\nUse `<c-w>c`."},"finish_reason":null}]}\r\n\r\n')
  wait(function() return text():find("Use `<c-w>c`.", 1, true) ~= nil end, "multiline SSE event was not decoded")
  check(vim.api.nvim_win_get_cursor(0)[1] == 2, "stream updates moved the reader's cursor")
  check(title():find("Streaming", 1, true), "stream marked complete before DONE")
  streaming.send('data: {"choices":[],"usage":{"completion_tokens":10}}\r\n\r\n')
  streaming.send('data: [DONE]\r\n\r\n')
  streaming.finish()
  wait(function() return title():find(" · Answer ", 1, true) ~= nil end, "stream did not finish")
  local streamed_question, thinking_section, streamed_answer = text():match("^## Your question\n\n(.-)\n\n%-%-%-\n\n(.-)\n\n%-%-%-\n\n## Answer\n\n(.*)$")
  check(streamed_question == "Show all close-window shortcuts", "stream removed question")
  check(thinking_section == "> [!NOTE] Thinking\n> Checking window shortcuts.\n> \n> Compare modes 中文.", "completed thinking was not preserved")
  check(streamed_answer == "### Close a window 中文\n\nUse `<c-w>c`.", "stream content was corrupted")
  rendered_heading()

  if markdown_runtime then
    local namespace = vim.api.nvim_get_namespaces()["render-markdown.nvim"]
    local note_row
    for i, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
      if line == "> [!NOTE] Thinking" then note_row = i - 1 end
    end
    wait(function()
      for _, mark in ipairs(vim.api.nvim_buf_get_extmarks(0, namespace, 0, -1, { details = true })) do
        if mark[2] == note_row and mark[4].virt_text then return true end
      end
      return false
    end, "thinking note was not rendered")
  end

  for _, field in ipairs({ "reasoning", "thinking" }) do
    streaming = start_stream()
    streaming.send('data: ' .. vim.json.encode({ choices = { { delta = { [field] = "Thinking alias " .. field }, finish_reason = vim.NIL } } }) .. '\n\n')
    wait(function() return text():find("> Thinking alias " .. field, 1, true) ~= nil end, "thinking alias not supported: " .. field)
    streaming.send(delta("Alias answer") .. 'data: [DONE]\n\n')
    streaming.finish()
    wait(function() return title():find(" · Answer ", 1, true) ~= nil end, "thinking alias stream did not finish")
    check(text():find("## Answer\n\nAlias answer", 1, true), "alias thinking mixed into answer")
  end

  -- Providers may end with a finish_reason instead of [DONE].
  streaming = start_stream()
  streaming.send('data: {"choices":[{"delta":{"content":"Finished answer"},"finish_reason":"stop"}]}\n\n')
  streaming.finish()
  wait(function() return title():find(" · Answer ", 1, true) ~= nil end, "finish_reason was ignored")
  check(not text():find("[!NOTE]", 1, true), "thinking note invented when provider sent no thinking")

  streaming = start_stream()
  streaming.send(delta("Keep this partial answer"))
  wait(function() return text():find("Keep this partial answer", 1, true) ~= nil end, "partial answer missing")
  streaming.send('data: {"error":{"message":"bad test-key in stream"}}\n\n')
  stream_notice("bad [redacted] in stream")
  check(text():find("Keep this partial answer", 1, true) and text():find("Response interrupted", 1, true), "stream error discarded partial answer")

  streaming = start_stream()
  streaming.send('data: {broken json}\n\n')
  stream_notice("invalid streaming JSON")
  streaming = start_stream()
  streaming.send('data: [DONE]\n\n')
  streaming.finish()
  stream_notice("no answer")
  streaming = start_stream()
  streaming.send(delta("Incomplete answer"))
  streaming.finish()
  stream_notice("ended before completion")
  check(text():find("Incomplete answer", 1, true), "premature EOF discarded answer")

  streaming = start_stream()
  streaming.send('data: {"choices":[{"delta":{"reasoning_content":"Incomplete thinking"},"finish_reason":null}]}\n\n')
  wait(function() return text():find("> Incomplete thinking", 1, true) ~= nil end, "partial thinking missing")
  streaming.finish()
  stream_notice("ended before completion")
  check(text():find("> Incomplete thinking", 1, true) and text():find("Response interrupted", 1, true), "interruption discarded thinking")

  streaming = start_stream()
  streaming.send(delta("Answer before connection dropped"))
  wait(function() return text():find("Answer before connection dropped", 1, true) ~= nil end, "connection-drop test did not receive content")
  streaming.abort()
  stream_notice("closed before the answer finished")
  check(text():find("Answer before connection dropped", 1, true), "connection drop discarded partial answer")

  streaming = start_stream()
  streaming.send(delta("Cancel this partial answer"))
  wait(function() return text():find("Cancel this partial answer", 1, true) ~= nil end, "cancel test did not receive content")
  local stream_window = vim.api.nvim_get_current_win()
  vim.fn.maparg("q", "n", false, true).callback()
  check(not vim.api.nvim_win_is_valid(stream_window), "closing did not cancel streamed answer")
  check(#notices == 0, "cancelled stream produced an error notification")
  response = { status = 200, body = { choices = { { message = { content = "# Close a window\n\nUse `<c-w>c`." } } } } }
  response.body.choices[1].message.reasoning_content = "Thinking from a JSON response"
  answer()
  check(text():find("> Thinking from a JSON response", 1, true), "JSON fallback discarded thinking")
  response.body.choices[1].message.reasoning_content = nil

  -- Follow-ups use the existing conversation window and its clean API history.
  local conversation_win, conversation_buf = vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
  local first_transcript, first_answer = text(), response.body.choices[1].message.content
  local first_question = requests[#requests].body.messages[3].content
  local function open_followup()
    local enter = vim.fn.maparg("<CR>", "n", false, true).callback
    check(type(enter) == "function", "follow-up Enter mapping missing")
    enter()
    local input_win = vim.api.nvim_get_current_win()
    check(input_win ~= conversation_win and vim.api.nvim_win_get_config(0).relative == "win", "follow-up is not an input float")
    -- Repeated activation focuses the same input instead of opening another one.
    enter()
    check(vim.api.nvim_get_current_win() == input_win, "duplicate follow-up input opened")
    return input_win
  end
  local function send_followup(question)
    local count = #requests
    local input_win = open_followup()
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(question, "\n", { plain = true }))
    vim.fn.maparg("<CR>", "i", false, true).callback()
    check(not vim.api.nvim_win_is_valid(input_win), "submitted input did not close")
    check(vim.api.nvim_get_current_win() == conversation_win and vim.api.nvim_get_current_buf() == conversation_buf, "follow-up replaced conversation window")
    wait(function() return #requests > count end, "follow-up request did not start")
    return requests[#requests]
  end
  response = { status = 200, body = { choices = { { message = { content = "### Other options\n\nUse `<c-w>q`." } } } } }
  local followup_question = 'What other keymaps do that? "中文"'
  local followup_request = send_followup(followup_question)
  wait(function() return title():find(" · Answer ", 1, true) ~= nil end, "second turn did not complete")
  local messages = followup_request.body.messages
  check(#messages == 5 and messages[1].role == "system", "follow-up history has wrong shape")
  check(messages[2].content:sub(-#reference) == reference, "follow-up omitted full reference")
  check(messages[3].role == "user" and messages[3].content == first_question, "first question missing from history")
  check(messages[4].role == "assistant" and messages[4].content == first_answer, "first answer missing from history")
  check(messages[5].role == "user" and messages[5].content == followup_question, "new question missing from history")
  check(text():sub(1, #first_transcript) == first_transcript, "follow-up discarded earlier transcript or thinking")
  check(text():find("## Your question\n\n" .. followup_question, 1, true), "new turn missing from transcript")
  check(title():find("Turn 2", 1, true), "turn counter missing")

  local count = #requests
  open_followup()
  vim.fn.maparg("<Esc>", "i", false, true).callback()
  check(#requests == count and vim.api.nvim_get_current_win() == conversation_win, "cancelled input sent a request or lost focus")
  open_followup()
  vim.fn.maparg("<CR>", "i", false, true).callback()
  check(#requests == count and vim.api.nvim_get_current_win() == conversation_win, "empty follow-up sent a request")

  local second_answer = response.body.choices[1].message.content
  response = { status = 200, stream = true }
  local third_request = send_followup("Which one should I use?")
  wait(function() return third_request.send ~= nil end, "third turn stream did not start")
  messages = third_request.body.messages
  check(#messages == 7 and messages[6].role == "assistant" and messages[6].content == second_answer, "third turn lost second answer or recorded cancelled input")
  check(messages[7].content == "Which one should I use?", "third question missing")
  vim.fn.maparg("<CR>", "n", false, true).callback()
  check(notice("Wait for this answer to finish") and vim.api.nvim_get_current_win() == conversation_win, "follow-up allowed concurrent requests")
  notices = {}
  third_request.send('data: {"choices":[{"delta":{"reasoning_content":"Compare the earlier options."},"finish_reason":null}]}\n\n')
  wait(function() return text():find("> Compare the earlier options.", 1, true) ~= nil end, "follow-up thinking was not streamed")
  third_request.send(delta("### Recommended\n\nUse `<c-w>c`.") .. 'data: [DONE]\n\n')
  third_request.finish()
  wait(function() return title():find(" · Answer ", 1, true) ~= nil end, "third turn did not complete")
  check(text():find(first_answer, 1, true) and text():find(second_answer, 1, true), "streaming follow-up removed earlier answers")

  response = { status = 401, body = { error = { message = "follow-up failure" } } }
  send_followup("This turn fails")
  stream_notice("follow-up failure")
  response = { status = 200, body = { choices = { { message = { content = "Recovered answer" } } } } }
  local recovery = send_followup("Continue after that error")
  wait(function() return title():find(" · Answer ", 1, true) ~= nil end, "conversation did not recover after failure")
  messages = recovery.body.messages
  check(#messages == 10 and messages[8].role == "assistant" and messages[8].content == "### Recommended\n\nUse `<c-w>c`.", "recovery lost completed history")
  check(messages[9].content == "This turn fails" and messages[10].content == "Continue after that error", "recovery lost user prompts or added an error as an assistant answer")
  check(text():find("follow-up failure", 1, true) and text():find("Recovered answer", 1, true), "recovery removed previous turn")

  local stale_input = open_followup()
  response = { status = 200, body = { choices = { { message = { content = "# Close a window\n\nUse `<c-w>c`." } } } } }
  answer("New conversation")
  check(not vim.api.nvim_win_is_valid(stale_input) and not vim.api.nvim_win_is_valid(conversation_win), "new conversation left stale windows")
  check(#requests[#requests].body.messages == 3, "new search inherited previous conversation")

  -- A reachable proxy serves an otherwise unresolvable provider. The env loader
  -- must expand references and support several assignments on the same line.
  settings('export http_proxy="http://127.0.0.1:' .. port .. '"\n'
    .. 'export HTTP_PROXY="$http_proxy" HTTPS_PROXY="$http_proxy" ALL_PROXY="$http_proxy"\n'
    .. 'all_proxy=socks5://127.0.0.1:1', "http://provider.invalid/v1")
  answer()
  check(requests[#requests].header:find("POST http://provider.invalid/v1/chat/completions", 1, true), "proxy was bypassed")

  local closed = uv.new_tcp()
  assert(closed:bind("127.0.0.1", 0))
  local closed_port = closed:getsockname().port
  closed:close()
  settings('export all_proxy="socks5://127.0.0.1:' .. closed_port .. '"')
  answer()
  check(notice("connecting directly"), "closed proxy wasn't reported")
  check(requests[#requests].header:find("POST /v1/chat/completions", 1, true), "direct fallback failed")
  notices = {}

  settings()
  response = { status = 401, body = { error = { message = "bad test-key" } } }
  error_answer("Provider error (HTTP 401): bad [redacted]")
  response = { status = 200, body = "not json" }
  error_answer("invalid JSON")
  response = { status = 200, body = { choices = {} } }
  error_answer("no answer")
  response = { status = 200, body = { error = { message = "unsupported model" } } }
  error_answer("unsupported model")
  settings("", "http://127.0.0.1:" .. closed_port .. "/v1")
  error_answer("Could not connect")

  -- Bound timeout verification without waiting two minutes or contacting HTTPS.
  -- It also checks that HTTPS_PROXY wins over ALL_PROXY for an HTTPS provider.
  local system, curl_options = vim.system
  vim.system = function(command, options, callback)
    if command[1] ~= "curl" then return system(command, options, callback) end
    curl_options = options
    vim.schedule(function() callback({ code = 28, stdout = "", stderr = "timeout" }) end)
    return { kill = function() end }
  end
  settings('export https_proxy="http://127.0.0.1:' .. port .. '"\n'
    .. 'export HTTPS_PROXY="$https_proxy" ALL_PROXY="socks5://127.0.0.1:1"', "https://provider.invalid/v1")
  error_answer("The request timed out")
  check(curl_options.stdin:find('proxy = "http://127.0.0.1:' .. port .. '"', 1, true), "HTTPS proxy priority wrong")
  check(curl_options.clear_env and curl_options.env.http_proxy == nil, "inherited proxy not cleared")
  check(curl_options.timeout == 121000 and curl_options.stdin:find("max-time = 120", 1, true), "timeout not bounded")
  vim.system = system

  settings()
  held = true
  local count = #requests
  assistant.submit("cancel this", reference)
  check(text():find("## Your question\n\ncancel this", 1, true), "question missing while preparing")
  wait(function() return #requests > count end, "held request did not start")
  check(text():find("## Answer\n\n*Thinking", 1, true), "loading view missing answer section")
  rendered_heading()
  local float = vim.api.nvim_get_current_win()
  local close = vim.fn.maparg("q", "n", false, true).callback
  check(type(close) == "function", "close mapping missing")
  close()
  check(not vim.api.nvim_win_is_valid(float), "close did not dismiss answer")
  check(vim.api.nvim_win_get_config(0).relative == "", "editing focus not restored")
  held = false
  response = { status = 200, body = { choices = { { message = { content = "# Close a window\n\nUse `<c-w>c`." } } } } }
  answer()

  vim.fn.delete(temp .. "/.ai/env")
  error_answer("Provider settings are missing")
  vim.fn.writefile({ "MODEL=test" }, temp .. "/.ai/env")
  error_answer("Set BASE_URL and API_KEY")
  settings('REASONING_EFFORT="unterminated')
  error_answer("Could not load provider settings")
  settings('http_proxy=invalid')
  error_answer("Invalid proxy URL")
  vim.fn.executable = function(name) return name == "curl" and 0 or executable(name) end
  assistant.submit("close window", reference)
  check(notice("curl is unavailable"), "missing curl not reported")
  vim.fn.executable = executable
  notices = {}
  count = #requests
  assistant.submit("   ", reference)
  check(#requests == count and notice("Type a question"), "empty query sent a request")

  -- Exercise the real fzf bridge through a controlled sink, including no-match
  -- output: the first line is always the question, never the selected action.
  local captured
  vim.fn.mkdir(temp .. "/autoload", "p")
  vim.fn.writefile(vim.split([[
    function! fzf#wrap(name, spec, bang)
      return a:spec
    endfunction
    function! fzf#run(spec)
      let g:find_actions_test_spec = a:spec
    endfunction
  ]], "\n", { plain = true }), temp .. "/autoload/fzf.vim")
  vim.opt.runtimepath:prepend(temp)
  settings()
  assistant.open({ args = "close window" })
  captured = vim.g.find_actions_test_spec
  check(captured.source[1] ~= nil, "search has no source")
  check(captured.options[#captured.options] == "close window", "initial query lost")
  vim.cmd([[call g:find_actions_test_spec['sink*'](['How to close window, show me all keymap', 'selected result'])]])
  wait(function() return requests[#requests].body.messages[3].content == "How to close window, show me all keymap" end, "selected result sent instead of query")
  vim.cmd([[call g:find_actions_test_spec['sink*'](['question with zero matches', 'question with zero matches'])]])
  wait(function() return requests[#requests].body.messages[3].content == "question with zero matches" end, "zero-match question lost")

  -- General chat starts with native input and no shortcut-specific context.
  local request_count = #requests
  vim.cmd("LLMChat")
  local initial_input = vim.api.nvim_get_current_win()
  local parent = vim.api.nvim_win_get_config(initial_input).win
  check(vim.api.nvim_win_get_config(initial_input).relative == "win", "general chat did not open input")
  check(#requests == request_count, "opening general chat sent a request")
  vim.fn.maparg("<Esc>", "i", false, true).callback()
  check(not vim.api.nvim_win_is_valid(initial_input) and not vim.api.nvim_win_is_valid(parent), "initial cancel left chat windows")
  check(#requests == request_count and vim.api.nvim_win_get_config(0).relative == "", "initial cancel sent request or lost editor focus")

  chat.open()
  initial_input = vim.api.nvim_get_current_win()
  parent = vim.api.nvim_win_get_config(initial_input).win
  vim.fn.maparg("<CR>", "i", false, true).callback()
  check(not vim.api.nvim_win_is_valid(parent) and #requests == request_count, "empty initial question sent request or left chat open")

  vim.cmd("LLMChat")
  initial_input = vim.api.nvim_get_current_win()
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { "Explain how rainbows form" })
  vim.fn.maparg("<CR>", "i", false, true).callback()
  wait(function() return #requests > request_count and title():find(" · Answer ", 1, true) end, "general answer did not arrive")
  messages = requests[#requests].body.messages
  check(#messages == 2 and messages[2].content == "Explain how rainbows form", "general prompt included unwanted context")
  check(messages[1].content:find("general-purpose", 1, true), "general chat still uses shortcut instructions")
  check(title():find("LLM chat", 1, true) and not vim.api.nvim_win_is_valid(initial_input), "general chat title or input dismissal failed")
  conversation_win, conversation_buf = vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
  first_transcript, first_answer = text(), response.body.choices[1].message.content
  local general_followup = send_followup("Explain it for a child")
  wait(function() return title():find(" · Answer ", 1, true) end, "general follow-up did not finish")
  messages = general_followup.body.messages
  check(#messages == 4 and messages[2].content == "Explain how rainbows form"
    and messages[3].role == "assistant" and messages[3].content == first_answer
    and messages[4].content == "Explain it for a child", "general follow-up lost history")
  check(text():find(first_transcript, 1, true), "general follow-up removed first transcript")

  -- The reusable API accepts a title, system prompt, and optional context.
  request_count = #requests
  chat.submit("Summarize this", { title = "Custom tool", system_prompt = "Custom system instructions",
    context = "Custom reference", context_title = "Custom data" })
  wait(function() return #requests > request_count and title():find(" · Answer ", 1, true) end, "custom tool did not finish")
  messages = requests[#requests].body.messages
  check(#messages == 3 and messages[1].content == "Custom system instructions"
    and messages[2].content == "Custom data:\n\nCustom reference" and messages[3].content == "Summarize this", "custom chat options ignored")
  check(title():find("Custom tool", 1, true), "custom title ignored")

  -- Command search captures built-ins and both scopes in the originating buffer.
  vim.api.nvim_create_user_command("AssistantTestCommand", function() error("Command must never execute") end, { nargs = "*", bang = true })
  vim.api.nvim_buf_create_user_command(0, "AssistantTestCommand", function() error("Command must never execute") end, { nargs = "?" })
  local command_reference, command_source = commands.reference()
  check(command_reference:find(":write  [built-in]  :w[rite]", 1, true), "built-in command summary missing")
  check(command_reference:find(":AssistantTestCommand  [global; args=*; supports !", 1, true), "global command metadata missing")
  check(command_reference:find(":AssistantTestCommand  [buffer-local; args=?", 1, true), "buffer-local command metadata missing")
  check(#command_source > 100, "available command list is incomplete")
  commands.open({ args = "write" })
  captured = vim.g.find_actions_test_spec
  check(captured.options[#captured.options] == "write", "command query lost")
  check(table.concat(captured.source, "\n"):find("AssistantTestCommand", 1, true), "command search source missing custom commands")
  request_count = #requests
  vim.cmd([[call g:find_actions_test_spec['sink*'](['How do I save all buffers?', ':AssistantTestCommand'])]])
  wait(function() return #requests > request_count and title():find(" · Answer ", 1, true) end, "command question did not arrive")
  messages = requests[#requests].body.messages
  check(#messages == 3 and messages[3].content == "How do I save all buffers?", "command selection submitted instead of question")
  check(messages[2].content:sub(-#command_reference) == command_reference, "command reference was changed or lost")
  check(messages[1].content:find("Ex commands", 1, true) and title():find("Commands assistant", 1, true), "command tool used wrong prompt or title")
  check(not messages[2].content:find("Complete find_actions reference", 1, true), "command tool inherited action reference")
  conversation_win, conversation_buf = vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
  first_answer = response.body.choices[1].message.content
  local command_followup = send_followup("And how do I quit afterwards?")
  wait(function() return title():find(" · Answer ", 1, true) end, "command follow-up did not finish")
  messages = command_followup.body.messages
  check(#messages == 5 and messages[4].content == first_answer
    and messages[5].content == "And how do I quit afterwards?", "command chat lost history")
  check(messages[2].content:sub(-#command_reference) == command_reference, "command follow-up lost originating reference")

  request_count = #requests
  vim.cmd("LLMChat New general topic")
  wait(function() return #requests > request_count and title():find(" · Answer ", 1, true) end, "LLMChat initial argument did not submit")
  messages = requests[#requests].body.messages
  check(#messages == 2 and messages[2].content == "New general topic", "new tool conversation inherited another tool's history")
end

local ok, err = xpcall(run, debug.traceback)
for _, client in ipairs(clients) do if not client:is_closing() then client:close() end end
server:close()
vim.fn.stdpath, vim.fn.executable, vim.notify = stdpath, executable, notify
vim.env.https_proxy, vim.env.http_proxy, vim.env.BASE_URL, vim.env.API_KEY, vim.env.MODEL = unpack(inherited)
vim.fn.delete(temp, "rf")
if not ok then io.stderr:write(err .. "\n"); vim.cmd("cquit 1") end
print("llm_chat, find_actions, find_commands: local integration checks passed")
vim.cmd("qa!")
