-- https://nvchad.com/docs/config/walkthrough

vim.api.nvim_command "set runtimepath^=~/.vim runtimepath+=~/.vim/after"
vim.api.nvim_command "let &packpath = &runtimepath"
vim.g.vim_plug_installed = true
local vimrc = "~/Software/vim/NvChad/vimrc_for_lua"
vim.cmd.source(vimrc)
vim.g.is_zen_mode = false
local vimrcfunctions = "~/Software/vim/NvChad/vimrc_functions"
vim.cmd.source(vimrcfunctions)

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
