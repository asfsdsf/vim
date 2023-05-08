local M = {}

M.lazy_nvim = {

  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      init = "",
      import = " ",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = " ",
      start = "🚀",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },

}

M.treesitter = {
  ensure_installed = {
    "bash",
    "bibtex",
    "c",
    "cmake",
    "cpp",
    "css",
    "diff",
    "go",
    "html",
    "java",
    "javascript",
    "json",
    "julia",
    "lua",
    "latex",
    "kotlin",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "typescript",
    "tsx",
    "vim",
  },
  ignore_install = {},
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  highlight = {
    -- disable = function(lang, buf)
    --     if lang == "latex" then
    --       return true
    --     end
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,
  },
}

-- To config lsp, see also:
-- ./lspconfig.lua
-- To config debugger, see also:
-- ./nvim-dap.lua
M.mason = {
  ensure_installed = {
    -- ***********************************************************************
    -- lua stuff
    -- ***********************************************************************
    "lua-language-server",
    -- formatter
    "stylua",

    -- ***********************************************************************
    -- web dev stuff
    -- ***********************************************************************
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    -- formatter
    "prettier",

    -- ***********************************************************************
    -- c/cpp stuff
    -- ***********************************************************************
    -- completion, linter
    "clangd",
    -- formatter
    "clang-format",
    -- debugger
    "cpptools",

    -- ***********************************************************************
    -- python stuff
    -- ***********************************************************************
    -- completion, linter
    "pyright",
    -- formatter
    "black",
    -- debugger
    "debugpy",

    -- ***********************************************************************
    -- go stuff
    -- ***********************************************************************
    -- completion, linter, formatter
    "gopls",
    -- debugger
    "delve",

    -- ***********************************************************************
    -- bash stuff
    -- ***********************************************************************
    -- completion, linter
    "bash-language-server",
    -- debugger
    "bash-debug-adapter",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },

      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}


return M
