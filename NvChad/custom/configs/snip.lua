-- For specification of code style,
-- see: https://google.github.io/styleguide/
if not pcall(require, "luasnip") then
  return {}
end

local ls = require("luasnip")
local function load_snip(snip_type)
  local snip_package = "custom.configs.luasnip." .. snip_type
  -- Dispose package so that it can be reloaded when use keymap <leader>fsR
  package.loaded[snip_package] = nil
  local snip = require(snip_package)
  ls.add_snippets(snip_type, snip)
end


-- ***********************************************************************
-- For quick jump
-- ***********************************************************************
require("custom.configs.luasnip.all")
require("custom.configs.luasnip.cpp")
require("custom.configs.luasnip.go")
require("custom.configs.luasnip.latex")
require("custom.configs.luasnip.lua")
require("custom.configs.luasnip.markdown")
require("custom.configs.luasnip.matlab")
require("custom.configs.luasnip.python")
require("custom.configs.luasnip.sh")
require("custom.configs.luasnip.vim")


-- ***********************************************************************
-- Reload all snippets
-- ***********************************************************************
local lua_types = {
  "all",
  "cpp",
  "go",
  "latex",
  "lua",
  "markdown",
  "matlab",
  "python",
  "sh",
  "vim",
}
for _, lua_type in ipairs(lua_types) do
  load_snip(lua_type)
end


-- ***********************************************************************
-- Load custom snippets which contains privacy information
-- ***********************************************************************
if pcall(require, "custom.configs.luasnip.private") then
  local snip_package = "custom.configs.luasnip." .. "private"
  -- Dispose package so that it can be reloaded when use keymap <leader>fsR
  package.loaded[snip_package] = nil
  local snip = require(snip_package)
  ls.add_snippets("all", snip)
end

-- ***********************************************************************
-- Some other options for luasnip
-- ***********************************************************************
local types = require("luasnip.util.types")
local opts = {
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "   <c-j> to choose", "Comment" } },
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { "   edit", "Comment" } },
      },
    },
  }
}
return opts
