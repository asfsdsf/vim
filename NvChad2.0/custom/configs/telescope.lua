local present, telescope = pcall(require, "telescope")

if not present then
  return
end

-- yank all prompt manager entries
local yank_all_entries = function(prompt_bufnr)
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local entry_display = require("telescope.pickers.entry_display")

  local picker = action_state.get_current_picker(prompt_bufnr)
  local manager = picker.manager

  local entries = {}
  for entry in manager:iter() do
    local display, _ = entry_display.resolve(picker, entry)
    table.insert(entries, display)
  end

  local text = table.concat(entries, "\n")

  actions.close(prompt_bufnr)

  vim.fn.setreg("+", text)
end

-- yank preview
local yank_preview_lines = function(prompt_bufnr)
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local picker = action_state.get_current_picker(prompt_bufnr)
  local previewer = picker.previewer
  local winid = previewer.state.winid
  local bufnr = previewer.state.bufnr

  local line_start = vim.fn.line("w0", winid)
  local line_end = vim.fn.line("w$", winid)

  local lines = vim.api.nvim_buf_get_lines(bufnr, line_start, line_end, false)

  local text = table.concat(lines, "\n")

  actions.close(prompt_bufnr)

  vim.fn.setreg("+", text)
end

telescope.setup {
  defaults = {
    layout_strategy = "vertical",
    wrap_results = true,
    -- Default configuration for telescope goes here:
    -- config_key = value,
    layout_config = {
      height = 100 ,
      width = 200 ,
      preview_cutoff = 10,
    },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
        ['<C-y>'] = yank_preview_lines,
        ['<m-p>'] = require('telescope.actions.layout').toggle_preview,
        ['<C-j>'] = "move_selection_next",
        ['<C-k>'] = "move_selection_previous",
      },
    },
    preview = {
      hide_on_startup = false -- hide previewer when picker starts
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
}

local extensions_list = { "themes", "terms", "bookmarks", "dap", "vim_bookmarks", "repo"}

-- load extensions
for _, ext in ipairs(extensions_list) do
  telescope.load_extension(ext)
end

