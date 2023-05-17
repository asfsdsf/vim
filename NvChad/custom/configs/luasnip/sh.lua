local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local ai = require("luasnip.nodes.absolute_indexer")


--- Parse options to lines as nodes
---@param options string: a string contain characters as options
---@return : lines as nodes
local function parse_options(options, parent, ostate)
  local lines = {}
  options = options[1][1]
  for idx = 1, #options do
    local option = options:sub(idx, idx)
    lines[#lines + 1] = t({"", '\t-' .. option .. '|'})
    lines[#lines + 1] = i(idx, option)
    lines[#lines + 1] = f(function (args)
      return string.rep(' ', 11 - #args[1][1]) .. "Description of option " .. args[1][1]
    end, {idx})
  end
  local snip = sn(nil, lines)
  snip.old_state = ostate or {}
  return snip
end

--- Handle options for which opts
---@param options ListIter[string]: lines of options
local function handle_options(options, parent, ostate)
  local nodes = {}
  options = options[1]
  for idx, option in pairs(options) do
    -- string like "v|version"
    if option == "" then
      goto continue
    end
    local option_str =  vim.split(vim.trim(option), ' ')[1]
    option_str = option_str:sub(2)
    nodes[#nodes+1] = t({"", "\t" .. option_str .. string.rep(' ', 11 - #option_str) .. ")  "})
    nodes[#nodes+1] = i(idx, {"do something"})
    nodes[#nodes+1] = t({"   ;;", ""})
      ::continue::
  end
  -- return sn(nil, {t""})
  local snip = sn(nil, nodes)
  snip.old_state = ostate or {}
  return snip
end

M = {
  s("getopts",
    fmt([[
__ScriptVersion="${}"
__BaseName=$(basename "\$0")

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{{
    echo "Usage :  $__BaseName [options] [--]

    Options:
    -h|help       Display this message
    -v|version    Display script version
    {}

    Examples:"

}}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

while getopts ":hv{}" opt
do
  case $opt in

    h|help     )  usage; exit 0   ;;

    v|version  )  echo "$__BaseName -- Version $__ScriptVersion"; exit 0   ;;
    {}
    * )  echo -e "\n  Option does not exist : $OPTARG\n"
          usage; exit 1   ;;

  esac    # --- end of case ---
done
shift $(($OPTIND-1))
{}
    ]], {
      i(1,{"version"}),
      d(3, parse_options, {2}),
      i(2,{"opts"}),
      d(4, handle_options, {3}),
      i(0),
    })
  ),
}
return M
