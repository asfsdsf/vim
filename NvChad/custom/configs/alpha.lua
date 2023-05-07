-- https://fsymbols.com/text-art/
local dump
dump = function (o)
   if type(o) == 'table' then
      local s = '{\n'
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '},\n'
   else
      return tostring(o)
   end
end

local function hsbToRGB(h, s, b)
    local r, g, bl
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = b * (1 - s)
    local q = b * (1 - f * s)
    local t = b * (1 - (1 - f) * s)

    i = i % 6

    if i == 0 then
        r, g, bl = b, t, p
    elseif i == 1 then
        r, g, bl = q, b, p
    elseif i == 2 then
        r, g, bl = p, b, t
    elseif i == 3 then
        r, g, bl = p, q, b
    elseif i == 4 then
        r, g, bl = t, p, b
    elseif i == 5 then
        r, g, bl = b, p, q
    end

    r = math.floor(r * 255)
    g = math.floor(g * 255)
    bl = math.floor(bl * 255)

    return string.format("#%02x%02x%02x", r, g, bl)
end


local startH, startS, startB, jumpH, jumpS, jumpB
startH = 0.2
jumpH = -0.2/20
startS = 0.5
jumpS = 0.5/20
startB = 0.7
jumpB = 0.3/20
for i = 1, 20 do
  local colori
  colori = hsbToRGB(startH, startS, startB)
  startH = startH + jumpH
  startS = startS + jumpS
  startB = startB + jumpB
  vim.api.nvim_set_hl(0, 'Logo'..i, { fg = colori })
end

local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local neovimIconLines = {
	[[                               __                ]],
	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

local iamzzLines = {
  [[██╗   █████╗ ███╗   ███╗  ███████╗███████╗ ]],
  [[██║  ██╔══██╗████╗ ████║  ╚════██║╚════██║ ]],
  [[██║  ███████║██╔████╔██║    ███╔═╝  ███╔═╝ ]],
  [[██║  ██╔══██║██║╚██╔╝██║  ██╔══╝  ██╔══╝   ]],
  [[██║  ██║  ██║██║ ╚═╝ ██║  ███████╗███████╗ ]],
  [[╚═╝  ╚═╝  ╚═╝╚═╝     ╚═╝  ╚══════╝╚══════╝ ]],
}

local coolLines = {
  [[┏━━┓                ]],
  [[┗┫┣┛                ]],
  [[╋┃┃╋┏━━┳┓┏┓┏━━━┳━━━┓]],
  [[╋┃┃╋┃┏┓┃┗┛┃┣━━┃┣━━┃┃]],
  [[┏┫┣┓┃┏┓┃┃┃┃┃┃━━┫┃━━┫]],
  [[┗━━┛┗┛┗┻┻┻┛┗━━━┻━━━┛]],
}

local bearLines = {
  [[   ▄▀▀▀▄▄▄▄▄▄▄▀▀▀▄    ]],
  [[   █▒▒░░░░░░░░░▒▒█    ]],
  [[    █░░█░░░░░█░░█     ]],
  [[ ▄▄  █░░░▀█▀░░░█  ▄▄  ]],
  [[█░░█ ▀▄░░░░░░░▄▀ █░░█ ]],
  [[█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█]],
  [[█░░╦─╦╔╗╦─╔╗╔╗╔╦╗╔╗░░█]],
  [[█░░║║║╠─║─║─║║║║║╠─░░█]],
  [[█░░╚╩╝╚╝╚╝╚╝╚╝╩─╩╚╝░░█]],
  [[█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█]],
}

local function lineToStartGradient(lines)
  local out = {}
  local jump
  jump = math.floor(20 / #lines)
  for i, line in ipairs(lines) do
    table.insert(out, { hi = {{"Logo"..(1+(i-1)*jump), 0, -1}}, line = line})
  end
  return out
end

local function lineToStartPopGradient(lines)
  local out = {}
  for i, line in ipairs(lines) do
    local hi = "StartLogo" .. i
    if i <= 6 then
      hi = "StartLogo" .. i + 6
    elseif i > 6 and i <= 12 then
      hi = "StartLogoPop" .. i - 6
    end
    table.insert(out, { hi = hi, line = line})
  end
  return out
end

local function lineToStartShiftGradient(lines)
  local out = {}
  for i, line in ipairs(lines) do
    local n = i
    if i > 6 and i <= 12 then
      n = i + 6
    elseif i > 12 then
      n = i - 6
    end
    table.insert(out, { hi = "StartLogo"..n, line = line})
  end
  return out
end

local cool = lineToStartGradient(coolLines)
local neovimIcon = lineToStartGradient(neovimIconLines)
local iamzz = lineToStartGradient(iamzzLines)
local bear = lineToStartGradient(bearLines)

local headers = {cool, neovimIcon, iamzz, bear}

local function header_chars()
  math.randomseed(os.time())
  return headers[math.random(#headers)]
end

-- Map over the headers, setting a different color for each line.
-- This is done by setting the Highligh to StartLogoN, where N is the row index.
-- Define StartLogo1..StartLogoN to get a nice gradient.
local function header_color()
  local lines = {}
  for i, lineConfig in pairs(header_chars()) do
    local hi = lineConfig.hi
    local line_chars = lineConfig.line
    local line = {
      type = "text",
      val = line_chars,
      opts = {
        hl = hi,
        shrink_margin = false,
        position = "center",
      },
    }
    table.insert(lines, line)
  end
  -- print(dump(lines))

  local output = {
    type = "group",
    val = lines,
    opts = { position = "center", },
  }

  return output
end


local thetaTheme = require("alpha.themes.theta")
local config = thetaTheme.config
local dashboard = require("alpha.themes.dashboard")
local buttons = {
  type = "group",
  val = {
    { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
    { type = "padding", val = 1 },
    dashboard.button("l", "鈴 Lazy", ":Lazy <CR>"),
    dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
    dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
    dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
    dashboard.button("m", "⌨  mappings configurations", ":exec ('e ' . fnamemodify($MYVIMRC, ':h') . '/lua/custom/mappings.lua') <CR>"),
    dashboard.button("s", "  Settings", ":exec ('e ' . fnamemodify($MYVIMRC, ':h') . '/lua/custom/plugins.lua') <CR>"),
    dashboard.button("b", "  Bookmarks", ":Telescope marks<CR>" ),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  },
  position = "center",
}

local cdir = vim.fn.getcwd()
local section_mru_cwd = {
    type = "group",
    val = {
        {
            type = "text",
            val = "Recent files",
            opts = {
                hl = "SpecialComment",
                shrink_margin = false,
                position = "center",
            },
        },
        { type = "padding", val = 1 },
        {
            type = "group",
            val = function()
                return { thetaTheme.mru(0,cdir,3) }
            end,
            opts = { shrink_margin = false },
        },
    },
}

local section_mru = {
    type = "group",
    val = {
        {
            type = "group",
            val = function()
                return { thetaTheme.mru(3,nil,7) }
            end,
            opts = { shrink_margin = false },
        },
    },
}
config.layout[2] = config.layout[1]
print("ewiofjwoeifjeiw")
config.layout[1] = header_color()
config.layout[3] = section_mru_cwd
config.layout[4] = section_mru
config.layout[6] = buttons

-- print(dump(config.layout[1]))

return config
