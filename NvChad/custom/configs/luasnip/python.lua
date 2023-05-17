local ls = require("luasnip")
M = {}

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

local function resolve_arg(arg_str)
  local arg_type = nil
  local option_value = nil
  if string.find(arg_str, "=") then
    local split = vim.split(arg_str, "=")
    arg_str = vim.trim(split[1])
    option_value = vim.trim(split[2])
  end
  if string.find(arg_str, ":") then
    local split = vim.split(arg_str, ":")
    arg_str = vim.trim(split[1])
    arg_type = vim.trim(split[2])
  end

  if arg_type then
    arg_str = arg_str .. ", " .. arg_type
  end
  if option_value then
    arg_str = arg_str .. ", optional"
  end
  arg_str = arg_str .. ":"
  if option_value then
    arg_str = arg_str .. " Default value is " .. option_value .. "."
  end
  return arg_str
end

local function generic_pdoc(ilevel, args)
  local nodes = { t({ "'''", string.rep("\t", ilevel) }) }
  nodes[#nodes + 1] = i(1, "Small Description.")
  nodes[#nodes + 1] = t({ "", "", string.rep("\t", ilevel) })
  -- nodes[#nodes + 1] = i(2, "Long Description")
  nodes[#nodes + 1] = t({ "", "", string.rep("\t", ilevel) .. "Args:" })

  local a = vim.tbl_map(function(item)
    local trimed = vim.trim(item)
    return trimed
  end, vim.split(args[1][1], ",", true))

  if args[1][1] == "" then
    a = {}
  end

  for idx, v in pairs(a) do
    nodes[#nodes + 1] = t({ "", string.rep("\t", ilevel + 1) .. resolve_arg(v) .. " " })
    nodes[#nodes + 1] = i(idx + 1, "Description For " .. v)
  end

  nodes[#nodes + 1] = t({ "" })
  return nodes, #a + 1
end

-- Dynamic node for empty/non-empty choice.
-- If the choice is empty, the node is empty, else it's insert node.
local function insertForNonEmpty(args)
  -- Node is like {t(""), fmt("\tReturns {}",{i(a+2)}) }
  -- one node, three lines.
  local choice = args[1][3]
  if #args[1] > 1 or vim.trim(args[1][1]) ~= "" then
    return sn(nil, { i(1) })
  else
    return sn(nil, t(""))
  end
end
local function pyfdoc(args, parent, ostate, opts)
  local nodes, a = generic_pdoc(1, args)
  -- nodes[#nodes + 1] = c(a + 1, { t(""), fmt("\tReturns {}",{i(a+2)}) })
  nodes[#nodes + 1] = c(a + 1, { t(" "), t({ "", "", "\tReturn: " }) })
  nodes[#nodes + 1] = d(a + 2, insertForNonEmpty, { a + 1 })
  nodes[#nodes + 1] = c(a + 3, { t(" "), t({ "", "", "\tRaises: " }) })
  nodes[#nodes + 1] = d(a + 4, insertForNonEmpty, { a + 3 })
  nodes[#nodes + 1] =
      t({ "", "", string.rep("\t", 1) .. "=======================", string.rep("\t", 1) .. "Examples:" })
  nodes[#nodes + 1] = t({ "", string.rep("\t", 1) .. ">>> " })
  nodes[#nodes + 1] = t({ "", "\t'''", "\t" })
  local snip = sn(nil, nodes)
  snip.old_state = ostate or {}
  return snip
end

-- pyfdoc = function(args)
--   -- the returned snippetNode doesn't need a position; it's inserted
--   -- "inside" the dynamicNode.
--   return sn(nil, {
--     -- jump-indices are local to each snippetNode, so restart at 1.
--     i(1, args[1])
--   })
-- end

local function pycdoc(args, parent, ostate)
  local nodes, _ = generic_pdoc(2, args)
  nodes[#nodes + 1] = t({ "", "\t\t'''", "" })
  local snip = sn(nil, nodes)
  snip.old_state = ostate or {}
  return snip
end

M = {
  s({ trig = "cls", dscr = "Documented Class Structure" }, {
    t("class "),
    i(1, { "CLASS" }),
    t("("),
    i(2, { "" }),
    t({ "):", "\t" }),
    t({ "def init(self," }),
    i(3),
    t({ "):", "\t\t" }),
    d(4, pycdoc, { 3 }),
    f(function(args)
      if not args[1][1] or args[1][1] == "" then
        return { "" }
      end
      local a = vim.tbl_map(function(item)
        local trimed = vim.trim(item)
        return "\t\tself." .. trimed .. " = " .. trimed
      end, vim.split(args[1][1], ",", true))
      return a
    end, {
      3,
    }),
    i(0),
  }),
  s({ trig = "def", dscr = "Documented Function Structure" }, {
    t("def "),
    i(1, { "function" }),
    t("("),
    i(2),
    t({ "):", "\t" }),
    -- d(3, pyfdoc, { 2 }, { user_args = 1 }),
    d(3, pyfdoc, { 2 }),
    i(0, { "pass" }),
  }),
  s({trig = '"""', dscr = "Generate docstring/annotation"},{
    f(function()
      require("neogen").generate()
      return ""
    end)
  })
}
return M
