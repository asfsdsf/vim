-- https://nvchad.com/docs/config/walkthrough

vim.api.nvim_command "set runtimepath^=~/.vim runtimepath+=~/.vim/after"
vim.api.nvim_command "let &packpath = &runtimepath"
vim.g.vim_plug_installed = true
vim.g.NvChadDir = "~/Software/vim/NvChad2.0"
local vimrc = vim.g.NvChadDir .. "/vimrc_for_lua"
vim.cmd.source(vimrc)
vim.g.is_zen_mode = false
local vimrcfunctions = vim.g.NvChadDir .. "/vimrc_functions"
vim.cmd.source(vimrcfunctions)

-- Enable cursorline
vim.cmd [[
   vmap c <Nop>

   augroup ilikecursorline
      autocmd VimEnter * :highlight CursorLine guibg=#696969
   augroup END

]]

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
