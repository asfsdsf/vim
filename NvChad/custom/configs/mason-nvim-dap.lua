local M = {}

-- ***********************************************************************

M.ensure_installed = { "python", "delve" }

-- ***********************************************************************
-- *                         PYTHON DEBUGGING                            *
-- ***********************************************************************

local python_opts = function(source_name)
    local dap = require "dap"
    dap.adapters.python = {
      type = "executable",
      command = vim.fn.system('printf $(dirname "$(realpath "$(which debugpy)")")') .. '/venv/bin/python',
      args = {
        "-m",
        "debugpy.adapter",
      },
    }
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = function()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local currentpythonpath=vim.fn.system('printf $(which python)')
          return currentpythonpath
        end
      },
    }
  end


-- ***********************************************************************
-- *                         C/CPP DEBUGGING                             *
-- ***********************************************************************


-- ***********************************************************************

M.handlers = {
  python = python_opts,
}

return M
