---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "chadracula",
  theme_toggle = { "chadracula", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
  transparency = true,

  -- Add icon to status bar fileInfo when buffer modified
  statusline = {
    -- theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    overriden_modules = function()
      -- local statusline0 = require "nvchad_ui.statusline.default"
      return {
        fileInfo = function()
          local icon = "  "
          local sep_r = " "
          local filename = (vim.fn.expand "%" == "" and "Empty ") or vim.fn.expand "%:t"

          if filename ~= "Empty " then
            local devicons_present, devicons = pcall(require, "nvim-web-devicons")

            if devicons_present then
              local ft_icon = devicons.get_icon(filename)
              icon = (ft_icon ~= nil and " " .. ft_icon) or ""
            end
            filename = " " .. filename
            if vim.bo[0].modified then
              filename = filename .. " "
            end
          end

          return "%#St_file_info#" .. icon .. filename .. "%#St_file_sep#" .. sep_r
        end,
      }
    end,

  }
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

-- override lazy.nvim settings
local overrides = require "custom.configs.overrides"
M.lazy_nvim = overrides.lazy_nvim

return M
