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
local servers = { "html", "cssls", "tsserver", "clangd", "pyright", "gopls", "vimls" }

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
