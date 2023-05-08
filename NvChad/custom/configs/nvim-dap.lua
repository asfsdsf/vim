-- To ensure tools installed:
-- See mason config in: 
-- ./overrides.lua
-- To config lsp, see also:
-- ./lspconfig.lua
local present, dap = pcall(require, "dap")

if not present then
  return
end
local prompt_args = function()
  local argument_string = vim.fn.input('Program arguments: ')
  return vim.fn.split(argument_string, " ", true)
end
-- adapter
-- dap.adapters.python = {
--   type = 'executable';
--   command = '/home/zky/Software/anaconda/anaconda3/envs/debugpy/bin/python';
--   args = { '-m', 'debugpy.adapter' };
-- }


-- ***********************************************************************
-- *                         PYTHON DEBUGGING                            *
-- ***********************************************************************

dap.adapters.python = {
  type = "executable",
  -- command = vim.fn.system('printf $(dirname "$(realpath "$(which debugpy)")")') .. '/venv/bin/python',
  command = '/home/zky/Software/anaconda/anaconda3/envs/debugpy/bin/python';
  args = { "-m", "debugpy.adapter", },
}
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";
    program = "${file}"; -- This configuration will launch the current file if used.
    args = prompt_args,
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local currentpythonpath=vim.fn.system('printf $(which python3)')
      return currentpythonpath
    end;
  },
}

-- ***********************************************************************
-- *                         GO DEBUGGING                                *
-- ***********************************************************************
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = {'dap', '-l', '127.0.0.1:${port}'},
  }
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
    args = prompt_args,
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  -- works with go.mod packages and sub packages 
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}

-- ***********************************************************************
-- *                         BASH DEBUGGING                              *
-- ***********************************************************************

-- local dap_utils = dap.utils
-- local BASH_DEBUG_ADAPTER_BIN = dap_utils.MASON_BIN_PATH .. "/bash-debug-adapter"
-- local BASHDB_DIR = dap_utils.MASON_PACKAGE_PATH .. "/bash-debug-adapter/extension/bashdb_dir"
local MASON_PATH = vim.fn.stdpath('data') .. "/mason"
local BASH_DEBUG_ADAPTER_BIN = MASON_PATH .. "/bin/bash-debug-adapter"
local BASHDB_DIR = MASON_PATH .. "/packages/bash-debug-adapter/extension/bashdb_dir"
dap.adapters.sh = {
  type = "executable",
  command = BASH_DEBUG_ADAPTER_BIN,
}
dap.configurations.sh = {
  {
    name = "Launch Bash debugger",
    type = "sh",
    request = "launch",
    program = "${file}",
    cwd = "${fileDirname}",
    pathBashdb = BASHDB_DIR .. "/bashdb",
    pathBashdbLib = BASHDB_DIR,
    pathBash = "bash",
    pathCat = "cat",
    pathMkfifo = "mkfifo",
    pathPkill = "pkill",
    env = {},
    args = prompt_args,
    -- showDebugOutput = true,
    -- trace = true,
  }
}


-- ***********************************************************************
-- *                         GENERAL DEBUGGING                           *
-- ***********************************************************************

-- set sign for dap
vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='', linehl='', numhl=''})


-- ***********************************************************************
-- *                          DAP UI CONFIG                              *
-- ***********************************************************************

local present, dapui = pcall(require, "dapui")

if not present then
  return
end
dapui.setup(
{
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "✕",
        pause = "⏸",
        play = "▶",
        run_last = "⟲",
        step_back = "←",
        step_into = "→",
        step_out = "↑",
        step_over = "↷",
        terminate = "■"
      }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = "single",
      max_height = 0.5,
      max_width = 0.5,
      mappings = {
        close = { "q", "<Esc>" }
      }
    },
    force_buffers = true,
    icons = {
      collapsed = "▸",
      current_frame = "▸",
      expanded = "▾"
    },
    layouts = { {
        elements = { {
            id = "scopes",
            size = 0.25
          }, {
            id = "breakpoints",
            size = 0.25
          }, {
            id = "stacks",
            size = 0.25
          }, {
            id = "watches",
            size = 0.25
          } },
        position = "left",
        size = 40
      }, {
        elements = { {
            id = "repl",
            size = 0.5
          }, {
            id = "console",
            size = 0.5
          } },
        position = "bottom",
        size = 10
      } },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = { "o", "<RightMouse>" },
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
  }
)
