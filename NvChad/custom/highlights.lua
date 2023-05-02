-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

-- See also: https://github.com/NvChad/nvchad.github.io/blob/src/src/routes/(index)/docs/config/theming.mdx

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
  },
  IndentBlanklineContextChar = {
    fg = "#e1e3e4",
  },
  DiffText = {
    bg = "#15ff00",
    fg = "red",
  },
  IndentBlanklineContextStart = {
    fg = "#15ff00",
  },
  CursorLine = { bg = "#696969" },
  CursorColumn = { bg = "#696969" },
  -- CursorLineNr = { fg = "#000000", bg = "#FFFFFF" },
}

---@type HLTable
M.add = {
  -- NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
