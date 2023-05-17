local present, neogen = pcall(require, "neogen")

if not present then
  return
end

local M = {
  snippet_engine = "luasnip",
  languages = {
    python = {
      template = {
        annotation_convention = "google_docstrings",         -- for a full list of annotation_conventions, see https://github.com/danymat/neogen#supported-languages
        -- for more template configurations, see the language's configuration file in configurations/{lang}.lua
      }
    },
  },
}
return M
