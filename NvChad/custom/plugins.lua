-- Default settings: ../plugins/init.lua

-- See also: https://github.com/NvChad/nvchad.github.io/tree/src/src/routes/(index)/docs/config

-- See also ./init.lua
-- See also ./mappings.lua

local overrides = require "custom.configs.overrides"

-- ***********************************************************************
-- Plugins *************************************************************
--   1. Nvchad default plugins
--   2. utility plugins
--   3. Search plugins
--   4. completion plugins
--   5. languages plugins
--   6. git support plugins
--   7. generic programming support
--   8. theme / interface plugins
--   -1. disable Nvchad default plugins
-- ***********************************************************************

-- ***********************************************************************
--   1. Nvchad default plugins
--     See also ./configs/overrides.lua
--     - nvim-lspconfig
--     - mason.nvim
--     - nvim-treesitter
--     - nvim-tree.lua
--     - which-key.nvim
-- ***********************************************************************

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
          require("core.utils").load_mappings "null_ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope,
  },

  {
    "folke/which-key.nvim",
    init = function()
      require("which-key").register({
        a = { name = "tools" },
        A = { name = "Actions" },
        b = { name = "buffers" },
        c = { name = "code" },
        d = { name = "dapDebug" },
        e = { name = "error" },
        f = { name = "file",
          v = { name = "config"},
        },
        g = { name = "git" },
        h = { name = "help",
          d = { name = "describe"},
        },
        i = { name = "insert" },
        l = { name = "session" },
        p = { name = "paste/project" },
        q = { name = "quit" },
        r = { name = "refactor" },
        s = { name = "search" },
        t = { name = "toggle/tab" },
        T = { name = "toggle" },
        v = { name = "vimux" },
        w = { name = "windows" },
        y = { name = "yank" },
        z = { name = "fold" },
      }, { prefix = "<leader>" })
      require("which-key").register({
        ["<leader>;"] = { name = "comment" },
        ["<leader>sk"] = { name = "Search key" },
      })
      require("which-key").register({
        h = { name = "help",
          d = { name = "describe" },
        }
      }, { prefix = "<a-x>" })
    end,
  },


-- ***********************************************************************
--   2. utility plugins
--     - better-escape.nvim             -- use jj or jk to escape insert mode
--     - toggle_maximize.vim            -- toggle maximize window
--     - fugitive
--     - vimux                          -- vim tmux integration
--     - vim-tmux-navigator             -- vim tmux integration
--     - vim-visual-multi               -- multiple cursors
--     - guess-indent.nvim              -- guess indent
--     - tomtom/tcomment_vim
-- ***********************************************************************

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "asfsdsf/toggle_maximize.vim",
    lazy = false,
  },

  {
    "benmills/vimux",
    lazy = false,
    cond = function()
        return os.getenv("TMUX") ~= nil
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cond = function()
        return os.getenv("TMUX") ~= nil
    end,
    config = function(_, opts)
      require("core.utils").load_mappings "vim_tmux_navigator"
    end,
  },

  {
    "mg979/vim-visual-multi",
    config = function()
      require "custom.configs.vim-visual-multi"
    end,
  },

  {
    "nmac427/guess-indent.nvim",
    config = function() require("guess-indent").setup {} end,
    lazy = false,
  },

  {
    "tomtom/tcomment_vim",
    lazy = false,
  },

  {
    "dhruvmanila/browser-bookmarks.nvim",
    version = "*",
    opts = {
      selected_browser = "chrome",
      url_open_command = "xdg-open",
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    init = function()
      require("core.utils").load_mappings "browser_bookmarks"
    end,
  },

  {
    "tom-anders/telescope-vim-bookmarks.nvim",
    dependencies = {
      "MattesGroeger/vim-bookmarks",
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "cljoly/telescope-repo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

-- ***********************************************************************
--   3. Search plugins
--     - undotree                       -- undo tree
--     - fzf                            -- fuzzy finder dependency for fzf.vim
--     - fzf.vim                        -- fuzzy finder
--     - vimtex                         -- latex support
-- ***********************************************************************

  {
    "mbbill/undotree",
    lazy = false,
  },

  {
    "junegunn/fzf",
    build = ":call fzf#install()",
    lazy = false,
  },

  {
    "junegunn/fzf.vim",
    dependencies = {
      {
        "junegunn/fzf",
      },
    },
    lazy = false,
  },

  {
    "lervag/vimtex",
    init = function()
        vim.g.copilot_no_tab_map = true
        vim.cmd [[
            imap <silent><script><expr> <C-r> copilot#Accept("\<CR>")
        ]]
    end,
    ft = "tex",
  },

-- ***********************************************************************
--   4. completion plugins
--     - copilot.vim                    -- github copilot
--     - fcitx.vim                      -- fcitx support
-- ***********************************************************************

  {
    "github/copilot.vim",
    init = function()
        vim.g.copilot_no_tab_map = true
        vim.cmd [[
            imap <silent><script><expr> <C-r> copilot#Accept("\<CR>")
        ]]
    end,
    event = "InsertEnter",
  },


-- ***********************************************************************
--   5. languages plugins
--     - nvim-dap                       -- debugger
-- ***********************************************************************

  {
    "mfussenegger/nvim-dap",
    enabled = vim.fn.has "win32" == 0,
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "nvim-dap" },
        cmd = { "DapInstall", "DapUninstall" },
        opts = { handlers = {} },
      },
      {
        "rcarriga/nvim-dap-ui",
        opts = { floating = { border = "rounded" } },
      },
      {
        "nvim-telescope/telescope-dap.nvim",
      },
    },

    config = function()
      require "custom.configs.nvim-dap"
      require("core.utils").load_mappings "dap"
    end,
  },

-- (auto switch chinese input method) keep and restore fcitx state when leaving/re-entering insert mode 
  {
    "lilydjwg/fcitx.vim",
    event = "InsertEnter",
  },

-- ***********************************************************************
--   6. git support plugins
--     - vim-gitgutter                  -- git gutter
--     - vim-fugitive                  -- git gutter
-- ***********************************************************************

  {
    "airblade/vim-gitgutter",
    lazy = false,
  },

  {
    "tpope/vim-fugitive",
    lazy = false,
    init = function()
      require("core.utils").load_mappings "fugitive"
    end,
  },


-- ***********************************************************************
--   8. theme / interface plugins
--     - alpha-nvim                     -- dashboard
--     - neo-tree                       -- file explorer
--     - rainbow_parentheses.vim        -- rainbow parentheses
--     - targets.vim                    -- text object
--     - vim-visual-multi               -- multiple cursors
--     - vim-surround                   -- surround text object
--     - zen-mode.nvim                  -- zen mode
-- ***********************************************************************
  {
    'goolord/alpha-nvim',
    lazy = false,
    config = function()
      require 'alpha'.setup(require "custom.configs.alpha")
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
    },
    config = function()
      require("core.utils").load_mappings "neotree"
      require "custom.configs.neo-tree"
    end,
  },

  {
    "kien/rainbow_parentheses.vim",
    lazy = false,
  },

  {
    "wellle/targets.vim",
    event = "InsertEnter",
  },

  {
    "mg979/vim-visual-multi",
    lazy = false,
  },

  {
    "tpope/vim-surround",
    event = "InsertEnter",
  },

  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },

-- ***********************************************************************
--   -1. disable Nvchad default plugins
--     - nvim-tree                     -- Replaced by neo-tree
-- ***********************************************************************

  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },

  {
    "numToStr/Comment.nvim",
    enabled = false,
  },
}

return plugins
