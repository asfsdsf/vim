M = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- set this if you want to always pull the latest change
  opts = {
    provider = "openai",
    cursor_applying_provider = "deepseekchat",
    openai = {
      endpoint = "https://api.deepseek.com",
      model = "deepseek-chat",
      timeout = 30000, -- Timeout in milliseconds
      max_tokens = 8192,
      api_key_name = "DEEPSEEK_API_KEY", -- the shell command must prefixed with `^cmd:(.*)`
    },
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      enable_token_counting = true, -- Whether to enable token counting. Default to true.
      enable_cursor_planning_mode = false, -- Whether to enable Cursor Planning Mode. Default to false.
      enable_claude_text_editor_tool_mode = false, -- Whether to enable Claude Text Editor Tool Mode.
    },
    vendors = {
        --- ... existing vendors
      deepseekchat = {
        __inherited_from = 'openai',
        endpoint = "https://api.deepseek.com",
        model = "deepseek-chat",
        timeout = 30000, -- Timeout in milliseconds
        max_tokens = 8192,
        api_key_name = "DEEPSEEK_API_KEY", -- the shell command must prefixed with `^cmd:(.*)`
      },
      doubao = {
        __inherited_from = 'openai',
        endpoint = "https://ark.cn-beijing.volces.com/api/v3",
        model = "doubao-1-5-pro-32k-250115",
        timeout = 30000, -- Timeout in milliseconds
        max_tokens = 8192,
        api_key_name = "DOUBAO_API_KEY", -- the shell command must prefixed with `^cmd:(.*)`
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
return M
