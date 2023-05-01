local present, dap = pcall(require, "dap")

if not present then
  return
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
