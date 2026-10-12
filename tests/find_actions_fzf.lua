-- Run with the installed fzf Vim plugin (or set FIND_ACTIONS_FZF_RUNTIME):
-- NVIM_APPNAME=NvChad nvim --clean --headless -l tests/find_actions_fzf.lua
local plugin = vim.env.FIND_ACTIONS_FZF_RUNTIME or (vim.fn.stdpath("data") .. "/lazy/fzf")
assert(vim.fn.filereadable(plugin .. "/plugin/fzf.vim") == 1, "Set FIND_ACTIONS_FZF_RUNTIME to the fzf plugin directory")
vim.opt.runtimepath:prepend(plugin)
vim.cmd.source(plugin .. "/plugin/fzf.vim")
vim.g.fzf_layout = { window = "belowright 30split enew" }
vim.env.FZF_DEFAULT_OPTS = ""
local assistant = dofile("NvChad/find_actions.lua")
assistant.setup()
local submitted
assistant.submit = function(question, reference) submitted = { question, reference } end
local function start(query)
  submitted = nil
  assistant.open({ args = query })
  assert(vim.wait(4000, function()
    return vim.bo.buftype == "terminal" and table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"):find("Actions>", 1, true)
  end, 10), "fzf did not start")
  return vim.b.terminal_job_id
end
local function enter(query)
  local job = start(query)
  vim.fn.chansend(job, "\r")
  assert(vim.wait(4000, function() return submitted ~= nil end, 10), "Enter did not submit")
  assert(submitted[1] == query, "selected row or altered query was submitted")
  assert(submitted[2]:find("SPC aa", 1, true), "reference missing")
  assert(vim.bo.buftype ~= "terminal", "fzf did not restore editing buffer")
end
enter("close window")
enter("How to close window, show me all keymap")
local job = start("cancel this query")
vim.fn.chansend(job, "\27")
assert(vim.wait(4000, function() return vim.bo.buftype ~= "terminal" end, 10), "Escape did not close search")
assert(submitted == nil, "Escape submitted a question")
print("find_actions: real fzf Enter and Escape checks passed")
vim.cmd("qa!")
