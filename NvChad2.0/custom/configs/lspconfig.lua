-- To ensure tools installed:
-- See mason config in: 
-- ./overrides.lua
-- To config debugger, see also:
-- ./nvim-dap.lua

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = { "html", "cssls", "clangd", "pyright", "gopls", "vimls", "bashls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- ***********************************************************************
-- ** LSP configurations *************************************************
-- ***********************************************************************

-- ***********************************************************************
-- pyright for python
-- ***********************************************************************
lspconfig.pyright.setup { 
}

local cmp_nvim_lsp = require "cmp_nvim_lsp"

-- ***********************************************************************
-- prevent offset encoding error for clangd
-- Delete this if the bug no longer exists
-- ***********************************************************************
lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = cmp_nvim_lsp.default_capabilities(),
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}
