 M = {
    "Kurama622/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    event = "VeryLazy",
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    config = function()
      local tools = require("llm.tools")
      require("llm").setup({
        url = "https://api.deepseek.com/chat/completions",
        model = "deepseek-chat",
        api_type = "openai",
        max_tokens = 4096,
        temperature = 0.3,
        top_p = 0.7,

        prompt = "You are a helpful programming assistant.",

        prefix = {
          user = { text = "😃 ", hl = "Title" },
          assistant = { text = "  ", hl = "Added" },
        },

        -- history_path = "/tmp/llm-history",
        save_session = true,
        max_history = 15,
        max_history_name_length = 20,

        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"]      = { mode = {"n", "i"}, key = "<c-s>" },
          ["Input:Cancel"]      = { mode = {"n", "i"}, key = "<C-c>" },
          ["Input:Resend"]      = { mode = {"n", "i"}, key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = {"n", "i"}, key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = {"n", "i"}, key = "<C-k>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"]    = { mode = "n", key = "<leader>ac" },
          ["Session:Close"]     = { mode = "n", key = {"<esc>", "Q"} },

          -- Scroll
          ["PageUp"]            = { mode = {"i","n"}, key = "<C-b>" },
          ["PageDown"]          = { mode = {"i","n"}, key = "<C-f>" },
          ["HalfPageUp"]        = { mode = {"i","n"}, key = "<C-u>" },
          ["HalfPageDown"]      = { mode = {"i","n"}, key = "<C-d>" },
          ["JumpToTop"]         = { mode = "n", key = "gg" },
          ["JumpToBottom"]      = { mode = "n", key = "G" },
        },
        app_handler = {
          OptimizeCode = {
            handler = tools.side_by_side_handler,
            -- opts = {
            --   streaming_handler = local_llm_streaming_handler,
            -- },
          },
          TestCode = {
            handler = tools.side_by_side_handler,
            prompt = [[ Write some test cases for the following code, only return the test cases.
            Give the code content directly, do not use code blocks or other tags to wrap it. ]],
            opts = {
              fetch_key = function()
                return vim.env.DEEPSEEK_API_KEY
              end,
              url = "https://api.deepseek.com/chat/completions",
              model = "deepseek-chat",
              api_type = "openai",
              right = {
                title = " Test Cases ",
              },
            },
          },
          OptimCompare = {
            handler = tools.action_handler,
            opts = {
              fetch_key = function()
                return vim.env.DEEPSEEK_API_KEY
              end,
              url = "https://api.deepseek.com/chat/completions",
              model = "deepseek-chat",
              api_type = "openai",
            },
          },

          Translate = {
            handler = tools.qa_handler,
            opts = {
              fetch_key = function()
                return vim.env.DEEPSEEK_API_KEY
              end,
              url = "https://api.deepseek.com/chat/completions",
              model = "deepseek-chat",
              api_type = "openai",

              component_width = "60%",
              component_height = "50%",
              query = {
                title = " 󰊿 Trans ",
                hl = { link = "Define" },
              },
              input_box_opts = {
                size = "15%",
                win_options = {
                  winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
              },
              preview_box_opts = {
                size = "85%",
                win_options = {
                  winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
              },
            },
          },

          -- check siliconflow's balance
          UserInfo = {
            handler = function()
              local key = os.getenv("LLM_KEY")
              local res = tools.curl_request_handler(
                "https://api.siliconflow.cn/v1/user/info",
                { "GET", "-H", string.format("'Authorization: Bearer %s'", key) }
              )
              if res ~= nil then
                print("balance: " .. res.data.balance)
              end
            end,
          },
          WordTranslate = {
            handler = tools.side_by_side_handler,
            prompt = "[[ Translate the following text to Chinese, please only return the translation. ]]",
            opts = {
              fetch_key = function()
                return vim.env.DOUBAO_API_KEY
              end,
              url = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
              model = "doubao-1-5-pro-32k-250115",
              api_type = "openai",
              right = {
                title = " Translation ",
              },
            },
          },
          CodeExplain = {
            handler = tools.flexi_handler,
            prompt = "Explain the following code, please only return the explanation",
            opts = {
              fetch_key = function()
                return vim.env.DOUBAO_API_KEY
              end,
              url = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
              model = "doubao-1-5-pro-32k-250115",
              api_type = "openai",
              enter_flexible_window = true,
            },
          },
          CommitMsg = {
            handler = tools.flexi_handler,
            prompt = function()
              -- Source: https://andrewian.dev/blog/ai-git-commits
              return string.format([[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

1. First line: conventional commit format (type: concise description) (remember to use semantic types like feat, fix, docs, style, refactor, perf, test, chore, etc.)
2. Optional bullet points if more context helps:
   - Keep the second line blank
   - Keep them short and direct
   - Focus on what changed
   - Always be terse
   - Don't overly explain
   - Drop any fluffy or formal language

Return ONLY the commit message - no introduction, no explanation, no quotes around it.

Examples:
feat: add user auth system

- Add JWT tokens for API auth
- Handle token refresh for long sessions

fix: resolve memory leak in worker pool

- Clean up idle connections
- Add timeout for stale workers

Simple change example:
fix: typo in README.md

Very important: Do not respond with any of the examples. Your message must be based off the diff that is about to be provided, with a little bit of styling informed by the recent commits you're about to see.

Based on this format, generate appropriate commit messages. Respond with message only. DO NOT format the message in Markdown code blocks, DO NOT use backticks:

```diff
%s
```
]],
                vim.fn.system("git diff --no-ext-diff --staged")
              )
            end,
            opts = {
              fetch_key = function()
                return vim.env.DOUBAO_API_KEY
              end,
              url = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
              model = "doubao-1-5-pro-32k-250115",
              api_type = "openai",
              enter_flexible_window = true,
              apply_visual_selection = false,
            },
          },
        },
    })
    end,
    keys = {
      { "\\ll", mode = "n", "<cmd>LLMSessionToggle<cr>" },
      { "\\lt", mode = "x", "<cmd>LLMAppHandler WordTranslate<cr>" },
      { "\\le", mode = "v", "<cmd>LLMAppHandler CodeExplain<cr>" },
      { "\\lt", mode = "n", "<cmd>LLMAppHandler Translate<cr>" },
      { "\\lc", mode = "x", "<cmd>LLMAppHandler TestCode<cr>" },
      { "\\lo", mode = "x", "<cmd>LLMAppHandler OptimCompare<cr>" },
      { "\\lu", mode = "n", "<cmd>LLMAppHandler UserInfo<cr>" },
      { "\\lg", mode = "n", "<cmd>LLMAppHandler CommitMsg<cr>" },
      -- { "\\lo", mode = "x", "<cmd>LLMAppHandler OptimizeCode<cr>" },
    },
  }
 return M
