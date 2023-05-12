---@type MappingsTable

-- See also ./init.lua
-- See also ./plugins.lua

-- ***********************************************************************
-- Mappings **************************************************************
--   1. Nvchad default mappings
--   9. disable Nvchad default mappings
-- ***********************************************************************

local M = {}

-- Default options for opts:
-- local opts = {
--   mode = "n", -- NORMAL mode
--   -- prefix: use "<leader>f" for example for mapping everything related to finding files
--   -- the prefix is prepended to every mapping part of `mappings`
--   prefix = "",
--   buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = false, -- use `nowait` when creating keymaps
-- }

M.telescope = {
  n = {
    ["<Space><Space>"] = { "<cmd> Telescope commands <CR>", "Find commands" },
    ["<Space>sc"] = { "<cmd> Telescope command_history <CR>", "Command history" },
    ["<Space>sM"] = { "<cmd> Telescope vim_bookmarks all <CR>", "Search all bookmarks" },
    ["<Space>sm"] = { "<cmd> Telescope vim_bookmarks current_file <CR>", "Search current file bookmarks" },
    ["<Space>s:"] = { "<cmd> Telescope command_history <CR>", "Command history" },
    ["<Space>ss"] = { "<cmd> Telescope search_history <CR>", "Search history" },
    ["<Space>s/"] = { "<cmd> Telescope search_history <CR>", "Search history" },
    ["<Space>st"] = { "<cmd> Telescope themes <CR>", "Search theme" },
    ["<Space>sj"] = { "<cmd> Telescope jumplist <CR>", "Jump lists" },
    ["<Space>skn"] = { "<cmd> Telescope jumplist <CR>", "Search normal mode key" },
    ["<Space>sp"] = { ":if executable('fdfind') | exec 'Telescope repo' | else | echo 'Command is not executable. apt install fd-find' | endif<CR>", "Search git projects" },
    ["<Space>gh"] = {"<cmd>:Telescope git_commits<CR>", "Telescope commits about current file"},
    ["<Space>ee"] = {"<cmd>:Telescope diagnostics<CR>", "Show all diagnostics"},
  }
}

M.bookmarks = {
  n = {
    ["ma"] = { "<cmd> :Telescope vim_bookmarks all <CR>", "Search all bookmarks" },
    ["ms"] = { ":!mkdir -p $HOME/.vim/vim_bookmarks<CR>:exec 'BookmarkSave ' . $HOME . '/.vim/vim_bookmarks/' . EscapePathToString(GetProjectPath()) . '.bm'<CR>", "Save project bookmarks" },
    ["ml"] = { ":lua require('telescope').load_extension('vim_bookmarks')<CR>:exec 'BookmarkLoad ' . $HOME . '/.vim/vim_bookmarks/' . EscapePathToString(GetProjectPath()) . '.bm'<CR>", "Load project bookmarks" },
  },
}

-- ***********************************************************************
--   1. Nvchad default mappings
-- ***********************************************************************

M.comment = {
  -- toggle comment in both modes
  n = {
    ["<leader>;;"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
    ["<Space>id"] = {"<cmd>:r !echo '***********************************************************************'<CR><cmd>: lua require('Comment.api').toggle.linewise.current()<CR>5l", ""},
  },

  v = {
    ["<leader>;"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}


-- ***********************************************************************
M.general = {
  n = {
    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>Tc"] = {":lua require('base46').toggle_transparency()<CR>", "Toggle transparency"},
    ["<c-c><c-o>"] = {"<cmd>:call OpenUrlUnderCursor()<CR>","Open url under cursor"},
  },
  i = {
    ["<c-s>"] = {"<c-o><cmd>:update<CR>", "Save file"},

  }
}

M.motions = {
  n = {
    ["<space>tp"] = {"<cmd>:call g:TogglePaste()<cr>", "Toggle paste mode"},
    ["gm"] = {"%", "Go to match pair"},
    ["H"] = {"^", "Start of line"},
    ["L"] = {"$", "End of line"},
    ["]e"] = {"       <cmd>:move +1<CR>", "Move line down"},
    ["[e"] = {"       <cmd>:move -2<CR>", "Move line up"},
    ["<leader>en"] = {":lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic"},
    ["<leader>ep"] = {":lua vim.diagnostic.goto_prev()<CR>", "Previous Diagnostic"},
    ["<leader>eN"] = {":lua vim.diagnostic.goto_prev()<CR>", "Previous Diagnostic"},
    ["<leader>es"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Show floating diagnostic",
    },
  },
  i = {
    ["<c-y>"] = {"<c-r>+", "Paste"},
    ["<c-x>"] = {"<c-o>:normal! 0v$hd<CR>", "Cut current line"},
    ["<c-b>"] = {"<left>","Move left"},
    ["<c-j>"] = {"<down>","Move down"},
    ["<c-k>"] = {"<up>","Move up"},
    ["<c-f>"] = {"<right>","Move right"},
    ["<c-h>"] = {"<left>","Move left"},
    ["<c-l>"] = {"<right>","Move right"},
    ["<a-b>"] = {"<c-left>","Word back"},
    ["<a-f>"] = {"<c-right>","Word forward"},
    ["<a-h>"] = {"<c-left>","Word back"},
    ["<a-l>"] = {"<c-right>","Word forward"},
    ["<a-j>"] = {"<c-o>o", "New line down"},
    ["<a-k>"] = {"<c-o>O", "New line up"},
    ["<c-a>"] = {"<c-o>^", "Move to end"},
    ["<c-e>"] = {"<c-o>$", "Move to start"},
  },
  c = {
    ["<c-y>"] = {"<c-r>+", "Paste"},
    ["<c-x>"] = {"<C-\\>eSetClipboard(getcmdline())<CR>", "Cut commands"},
    ["<c-a>"] = {"<home>", ""},
    ["<c-e>"] = {"<end>", ""},
    ["<c-h>"] = {"<left>","Move left"},
    ["<c-l>"] = {"<right>","Move right"},
    -- ["<c-f>"] = {"<right>","Move right"},
    ["<c-b>"] = {"<left>","Move left"},
    ["<a-b>"] = {"<c-left>","Word back"},
    ["<a-f>"] = {"<c-right>","Word forward"},
    ["<a-h>"] = {"<c-left>","Word back"},
    ["<a-l>"] = {"<c-right>","Word forward"},
  },
  v = {
    ["gm"] = {"%", "Go to match pair"},
    ["H"] = {"^", "Start of line"},
    ["L"] = {"$", "End of line"},
  }
}

M.tabs = {
  n = {
    ["<leader>tl"] = {"gt", "Next tab"},
    ["<leader>th"] = {"gT", "Previous tab"},
    ["<leader>tn"] = {"<cmd>:tabnew<CR>", "New tab"},
    ["<leader>tc"] = {"<cmd>:tabclose<CR>", "Close tab"},
  },
}

M.buffers = {
  n = {
    ["<a-n>"] = {"<cmd>:bn<CR>", "Next buffer"},
    ["<a-p>"] = {"<cmd>:bp<CR>", "Previous buffer"},
    ["<Space>bn"] = {"<cmd>:bn<CR>", "Next buffer"},
    ["]b"] = {"<cmd>:bn<CR>", ""},
    ["<Space>bp"] = {"<cmd>:bp<CR>", "Previous buffer"},
    ["[b"] = {"<cmd>:bp<CR>", ""},
    ["<Space><Tab>"] = {"<cmd>:b#<CR>", "Most recent buffer"},
    ["<Space>bd"] = {"<cmd>:call CloseBuffer()<CR>", "Close buffer"},
    ["<Space>bm"] = {"<cmd>:messages<CR>", "Message buffer"},
    ["<Space>bM"] = {"<cmd>:lua require('notify').dismiss({pending = true})<CR>", "Maximize buffer"},
    -- ["<Space>bb"] = {"<cmd>:FzfBuffers!<CR>", "Show all buffers"},
    ["<Space>bb"] = {"<cmd>lua require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true })<CR>", "Show all buffers"},
    ["<Space>bs"] = {"<cmd>:Lazy load scratch.vim<CR><cmd>:Scratch<CR>", "Scratch buffer"},
    ["<Space>bx"] = {"<cmd>:call CloseMaximize()<CR><cmd>:bp<cr><cmd>:silent! exec 'bd #'<CR><cmd>:close<CR>", "Close buffer and window"},
    ["<Space>b1"] = {"<cmd>:bfirst<CR>", ""},
    ["<Space>b2"] = {"<cmd>:call g:GotoNthBuffer('1')<CR>", ""},
    ["<Space>b3"] = {"<cmd>:call g:GotoNthBuffer('2')<CR>", ""},
    ["<Space>b4"] = {"<cmd>:call g:GotoNthBuffer('3')<CR>", ""},
    ["<Space>b5"] = {"<cmd>:call g:GotoNthBuffer('4')<CR>", ""},
    ["<Space>b6"] = {"<cmd>:call g:GotoNthBuffer('5')<CR>", ""},
    ["<Space>b7"] = {"<cmd>:call g:GotoNthBuffer('6')<CR>", ""},
    ["<Space>b8"] = {"<cmd>:call g:GotoNthBuffer('7')<CR>", ""},
    ["<Space>b9"] = {"<cmd>:call g:GotoNthBuffer('8')<CR>", ""},
  }
}

M.windows = {
  n = {
    ["<A-j>"] = {"<C-W>j", ""},
    ["<A-k>"] = {"<C-W>k", ""},
    ["<A-l>"] = {"<C-W>l", ""},
    ["<A-h>"] = {"<C-W>h", ""},
    ["<A-z>"] = {"<cmd>:call ToggleZenMode(1)<CR>", "Toggle zen mode(with tmux support)"},
    ["<Space>wM"] = {"<cmd>:call ToggleZenMode(0)<CR>", "Toggle zen mode"},
    ["<Space>wh"] = {"<cmd>:call CloseMaximize()<CR><C-w>h", "Window go left"},
    ["<Space>wj"] = {"<cmd>:call CloseMaximize()<CR><C-w>j", "Window go down"},
    ["<Space>wk"] = {"<cmd>:call CloseMaximize()<CR><C-w>k", "Window go up"},
    ["<Space>wl"] = {"<cmd>:call CloseMaximize()<CR><C-w>l", "Window go right"},
    ["<Space>wH"] = {"<cmd>:call CloseMaximize()<CR><C-w>H", "Move window left"},
    ["<Space>wJ"] = {"<cmd>:call CloseMaximize()<CR><C-w>J", "Move window down"},
    ["<Space>wK"] = {"<cmd>:call CloseMaximize()<CR><C-w>K", "Move window up"},
    ["<Space>wL"] = {"<cmd>:call CloseMaximize()<CR><C-w>L", "Move window right"},
    ["<Space>w/"] = {"<cmd>:call CloseMaximize()<CR><cmd>:vs<CR>", "Split window right"},
    ["<Space>w-"] = {"<cmd>:call CloseMaximize()<CR><cmd>:sp<CR>", "Split window down"},
    ["<Space>ww"] = {"<cmd>:call CloseMaximize()<CR><C-w>w", "Switch to recent window"},
    ["<Space>w="] = {"<cmd>:call CloseMaximize()<CR><C-w>=", "Balance window size"},
    ["<Space>wd"] = {"<cmd>:call CloseMaximize()<CR><cmd>:close<CR>", "Close window"},
    ["<Space>wx"] = {"<cmd>:call CloseMaximize()<CR><cmd>:bp<cr><cmd>:silent! exec 'bd #'<CR><cmd>:close<CR>", "Close window and buffer"},
    ["<Space>wo"] = {"<cmd>:call CloseMaximize()<CR><C-w><C-o>", "Circle window"},
    ["<c-down>"] = {"2<C-w>-", "Resize Window down"},
    ["<c-up>"] = {"2<C-w>+", "Resize window up"},
    ["<c-left>"] = {"2<C-w><", "Resize window left"},
    ["<c-right>"] = {"2<C-w>>", "Resize window right"},
    ["<Space>1"] = {" <cmd>:call CloseMaximize()<CR>1<C-w><C-w>", ""},
    ["<Space>2"] = {" <cmd>:call CloseMaximize()<CR>2<C-w><C-w>", ""},
    ["<Space>3"] = {" <cmd>:call CloseMaximize()<CR>3<C-w><C-w>", ""},
    ["<Space>4"] = {" <cmd>:call CloseMaximize()<CR>4<C-w><C-w>", ""},
    ["<Space>5"] = {" <cmd>:call CloseMaximize()<CR>5<C-w><C-w>", ""},
    ["<Space>6"] = {" <cmd>:call CloseMaximize()<CR>6<C-w><C-w>", ""},
    ["<Space>7"] = {" <cmd>:call CloseMaximize()<CR>7<C-w><C-w>", ""},
    ["<Space>8"] = {" <cmd>:call CloseMaximize()<CR>8<C-w><C-w>", ""},
    ["<Space>9"] = {" <cmd>:call CloseMaximize()<CR>9<C-w><C-w>", ""},
    ["<A-1>"] = {" <cmd>:call VimspectorToggleHide(1,1)<CR>", ""},
    ["<A-2>"] = {" <cmd>:call VimspectorToggleHide(2,1)<CR>", ""},
    ["<A-3>"] = {" <cmd>:call VimspectorToggleHide(3,1)<CR>", ""},
    ["<A-4>"] = {" <cmd>:call VimspectorToggleHide(4,1)<CR>", ""},
    ["<A-5>"] = {" <cmd>:call VimspectorToggleHide(5,1)<CR>", ""},
    ["<A-6>"] = {" <cmd>:call VimspectorToggleHide(6,1)<CR>", ""},
    ["<A-7>"] = {" <cmd>:call VimspectorToggleHide(7,1)<CR>", ""},
    ["<A-8>"] = {" <cmd>:call VimspectorToggleHide(8,1)<CR>", ""},
    ["<A-9>"] = {" <cmd>:call VimspectorToggleHide(9,1)<CR>", ""},
    ["<space><A-1>"] = {" <cmd>:call VimspectorToggleHide(1,2)<CR>", ""},
    ["<space><A-2>"] = {" <cmd>:call VimspectorToggleHide(2,2)<CR>", ""},
    ["<space><A-3>"] = {" <cmd>:call VimspectorToggleHide(3,2)<CR>", ""},
    ["<space><A-4>"] = {" <cmd>:call VimspectorToggleHide(4,2)<CR>", ""},
    ["<space><A-5>"] = {" <cmd>:call VimspectorToggleHide(5,2)<CR>", ""},
    ["<space><A-6>"] = {" <cmd>:call VimspectorToggleHide(6,2)<CR>", ""},
    ["<space><A-7>"] = {" <cmd>:call VimspectorToggleHide(7,2)<CR>", ""},
    ["<space><A-8>"] = {" <cmd>:call VimspectorToggleHide(8,2)<CR>", ""},
    ["<space><A-9>"] = {" <cmd>:call VimspectorToggleHide(9,2)<CR>", ""},
    ["<c-1>"] = {" <cmd>:call VimspectorToggleHide(1,2)<CR>", ""},
    ["<c-2>"] = {" <cmd>:call VimspectorToggleHide(2,2)<CR>", ""},
    ["<c-3>"] = {" <cmd>:call VimspectorToggleHide(3,2)<CR>", ""},
    ["<c-4>"] = {" <cmd>:call VimspectorToggleHide(4,2)<CR>", ""},
    ["<c-5>"] = {" <cmd>:call VimspectorToggleHide(5,2)<CR>", ""},
    ["<c-6>"] = {" <cmd>:call VimspectorToggleHide(6,2)<CR>", ""},
    ["<c-7>"] = {" <cmd>:call VimspectorToggleHide(7,2)<CR>", ""},
    ["<c-8>"] = {" <cmd>:call VimspectorToggleHide(8,2)<CR>", ""},
    ["<c-9>"] = {" <cmd>:call VimspectorToggleHide(9,2)<CR>", ""},
  },
  i = {

  },
}

M.search = {
  n = {
    ["<Space>/"] = {" <cmd>:Ag!<CR>", "Search in directory(Ag)"},
    ["<leader>b/"] = {"<cmd>:Lines<CR>", "Search across buffer"},
    -- ["<c-f>"] = {" <cmd>:w<CR><cmd>:AgCurrentFile!<CR>", ""},
    ["<c-f>"] = {" <cmd>:BLines<CR>", "Search lines"},
    ["<c-h>"] = {":%s//gc<left><left><left>", "Replace"},
    ["<space>fs"] = {"<cmd>:w !sudo tee %<CR>", ""},
    ["<Space>fr"] = {"<cmd>:call CloseMaximize()<CR><cmd>:FzfMrf!<CR>", "Recent files"},
    ["<Space>fvv"] = {"<cmd>:OpenVimrcDotFile<CR>", "Open vim config"},
    ["<Space>fvd"] = {"<cmd>:exec ('e ' . fnamemodify($MYVIMRC, ':h') . '/lua/custom/plugins.lua') <CR>", "Open settings file"},
    ["<Space>fvD"] = {"<cmd>:exec ('e ' . fnamemodify($MYVIMRC, ':h') . '/lua/plugins/init.lua') <CR>", "Open default settings file"},
    ["<Space>fvm"] = {"<cmd>:exec ('e ' . fnamemodify($MYVIMRC, ':h') . '/lua/custom/mappings.lua') <CR>", "Open mappings file"},
    ["<Space>fvM"] = {"<cmd>:exec ('e ' . fnamemodify($MYVIMRC, ':h') . '/lua/core/mappings.lua') <CR>", "Open default mappings file"},
    ["<Space>fvi"] = {"<cmd>:exec ('e ' . fnamemodify($MYVIMRC, ':h') . '/lua/custom/init.lua') <CR>", "Open init file"},
    ["<Space>fvf"] = {"<cmd>:exec ('e ' . g:NvChadDir . '/vimrc_functions') <CR>", "Open functions file"},
    ["<Space>fvc"] = {"<cmd>:exec ('e ' . g:NvChadDir . '/vimrc_for_lua') <CR>", "Open command file"},
    ["<Space>fO"] = {"<cmd>:!cd %:p:h && xdg-open '<cfile>' & <CR>", ""},
    ["<Space>fd"] = {"<cmd>:!nautilus %:p:h &<CR>", "Open in external directory"},
    ["<Space>fo"] = {"<cmd>:!cd %:p:h && xdg-open %:p & <CR>", "Open with external app"},
    -- ["<Space>ft"] = {"<cmd>:silent! !gnome-terminal --working-directory=%:p:h &<CR>", ""},
    ["<Space>ft"] = {"<cmd>:silent! !x-terminal-emulator &<CR>", "Open external terminal"},
    ["<Space>ff"] = {"<cmd>:call CloseMaximize()<CR><cmd>:call g:OpenFileByPath()<CR>", "Open file"},
    ["<Space>pf"] = {"<cmd>:call CloseMaximize()<CR><cmd>:GFiles!<CR>", "Open file in this project"},
    ["<Space>pp"] = { ":if executable('fdfind') | exec 'Telescope repo' | else | echo 'Command is not executable. apt install fd-find' | endif<CR>", "Search git projects" },
    ["<Space>pF"] = {"<cmd>:call CloseMaximize()<CR><cmd>:Files!<CR>", "Open file in this directory"},
    ["''"] = {"<cmd>:Marks<CR>", "Show all marks"},
    ["<Space>hdk"] = {"<cmd>Maps<CR>", "Show all keymaps"},
    ["<Space>hds"] = {"<cmd>Snippets<CR>", "Show all snippets"},
    ["<Space>hdv"] = {"<cmd>Telescope vim_options<CR>", "Show all vim options"},
    ["<Space>hdp"] = {"<cmd>Lazy show<CR>", "Show all plugins"},
  },
  i = {
    ["<a-x>hdk"] = {"<plug>(fzf-maps-i)", "Show keymaps"},
  },
  v = {
    ["*"] = {'"vy<cmd>:call SearchSelected()<CR>',"Search selected region"},
    ["<Space>/"] = {"\"vy<cmd>:exec 'Ag!' . escape(@v,'/\\()*+?[]$^<bar>')<CR>", "Search selection in current directory"},
  },
  x = {
    ["<c-h>"] = {":s//gc<left><left><left>","Replace in the region"},
  },
  c = {
    ["<c-f>"] = {"<cmd>call SearchHistoryHandler()<CR>","Search command/search history"},
  }
}

M.utils = {
  n = {
    ["<Space>fy"] = {"<cmd>:let @+ = expand('%:p')<CR><cmd>:echo 'current file path copied'<CR>", "Copy file path"},
    ["<Space>yy"] = {"<cmd>:let @+ = expand('%:p')<CR><cmd>:echo 'current file path copied'<CR>", "Copy file path"},
    ["<Space>fe"] = {"<cmd>:exec 'e ' . expand(@+)<CR>", "Edit file with path in clipboard"},
    ["<Space>ye"] = {"<cmd>:exec 'e ' . expand(@+)<CR>", "Edit file with path in clipboard"},
    ["<Space>pP"] = {"<cmd>:exec 'e ' . expand(@+)<CR>", "Edit file with path in clipboard"},
    -- ["<Space><Space>"] = {"<cmd>:Commands<CR>", ""},
    ["<Space><Space>"] = {":<c-f>", "Find commands"},
    ["<f5>"] = {"<cmd>:e<CR>", "Update file"},
    ["<Space>z+"] = {"zR", "Unfold all"},
    ["<Space>z-"] = {"zM", "Fold all"},
    ["<Space>qq"] = {"<cmd>:call CloseMaximize()<CR><cmd>:qa<CR>", "Quit"},
    ["<Space>cd"] = {"<cmd>:cd %:h<CR><cmd>:silent! Gcd<CR>", "Change working directory to current"},
    ["<Space>tw"] = {"<cmd>:ToggleWrap<CR>", "Toggle wrap"},
    ["<Space>tf"] = {"<cmd>:lua require'treesitter-context'<CR>:TSContextToggle<CR>", "Toggle show environment(function)"},
    ["<C-t>"] = {"<cmd>:lua require'treesitter-context'<CR>:TSContextToggle<CR>", "Toggle show environment(function)"},
    ["<space>aa"] = {"<cmd>:FindActions<CR>", "Show actions help"},
    ["<space>aA"] = {":FindActionsFor<space>", "Show actions for"},
    ["<space>AA"] = {":FindActionsFor<space>", "Show actions for"},
    ["<space>ag"] = {"<cmd>:!gedit %<CR>", "Open in gedit"},
    ["<space>au"] = {"<cmd>:Lazy load undotree<CR><cmd>:UndotreeToggle<CR>", "Undo tree toggle"},
    -- ["<space>as"] = {"<cmd>:terminal<CR>", ""},
    ["<space>as"] = {"<cmd>:vertical terminal ++curwin<CR>", ""},
    ["<space>hr"] = {"<cmd>:exec 'e ' . g:toBeTranslate_file<CR><c-w><c-o>:vs<CR><C-w>l:exec 'e ' . g:translation_dir . '/translated.txt'<CR><c-w>h", "Interactive translate"},
    ["<Space>hc"] = {"<cmd>:<C-u>Ydc<CR>", "Translate word under cursor"},
    ["<Space>htc"] = {"<cmd>:<C-u>Yde<CR>", ""},
    ["<leader>;;"] = {"<cmd>:TComment<CR>", "Comment current line"},
    ["<Space>id"] = {"<cmd>:r !echo '***********************************************************************'<CR><cmd>:TComment<CR>5l", ""},
  },
  i = {
    ["<A-z>"] = {"<cmd>call ToggleZenMode(1)<CR>", ""},
    ["<C-t>"] = {"<cmd>lua require'treesitter-context'<CR><cmd>TSContextToggle<CR>", "Toggle show environment(function)"},
  },
  v = {
    ["<Space>hc"] = {"\"vy <cmd>:call Translate()<CR>", "Translate visual region"},
  }
}

M.display = {
  n = {
    ["<Space>Tn"] = {"<cmd>:call ToggleTheme()<CR>", "Toggle theme"},
    ["<Space>Tl"] = {"<cmd>:call ToggleLineNumber()<CR>", "Toggle line number"},
    ["<Space>TL"] = {"<cmd>:windo call ToggleLineNumber()<CR>", "Toggle all window line number"},
    ["<Space>TT"] = {"<cmd>:call ToggleAllAuxiliaryDisplay()<CR>", "Toggle all auxiliary display"},
    ["<Space>tT"] = {"<cmd>:call ToggleAllAuxiliaryDisplay()<CR>", "Toggle all auxiliary display"},
    ["<Space>tt"] = {"<cmd>:call ToggleCurrentAuxiliaryDisplay()<CR>", "Toggle auxiliary display"},
    ["<Space>Tg"] = {"<cmd>:GitGutterToggle<CR>", "Toggle git gutter"},
    ["<Space>Tb"] = {"<cmd>:call ToggleShowTabLine()<CR>","Toggle buffer line (tab line)"},
  },

}

M.session = {
  n = {

  }
}

M.treesitter = {
  n = {
    -- ["<leader>tt"] = { ":TSPlaygroundToggle<CR>", "Toggle treesitter playground" },
  },
}

M.vim_tmux_navigator = {
  plugin = true,
  n = {
    ["<a-l>"] = {":call CloseMaximize()<CR><cmd>:TmuxNavigateRight<CR>", "Go to window right (with tmux support)."},
    ["<a-h>"] = {":call CloseMaximize()<CR><cmd>:TmuxNavigateLeft<CR>", "Go to window right (with tmux support)."},
    ["<a-j>"] = {":call CloseMaximize()<CR><cmd>:TmuxNavigateDown<CR>", "Go to window right (with tmux support)."},
    ["<a-k>"] = {":call CloseMaximize()<CR><cmd>:TmuxNavigateUp<CR>", "Go to window right (with tmux support)."},
  }
}

M.undotree = {
  plugin = true,
  n = {
    ["<leader>au"] = { ":let g:undotree_used=1<CR>:UndotreeToggle<CR>", "toggle undotree" },
  },
}

M.copilot = {
  plugin = true,
  n = {
    ["<leader>cp"] = { ":Copilot panel<CR>", "Copilot candidates" },
  },
  i = {
    ["<a-i>"] = { "<esc>:Copilot panel<CR>", "Copilot candidates" }
  }
}

M.neotree = {
  n = {
    ["<leader>0"] = { ":lua require'neo-tree'<CR>:call CloseMaximize()<CR><cmd>:NeoTreeFocusToggle<CR>", "Toggle neo-tree" },
    ["<leader>fp"] = { ":lua require'neo-tree'<CR>:call CloseMaximize()<CR><cmd>:Neotree  dir=%:p:h:h reveal_file=%:p reveal_force_cwd<CR>", "show file in neo-tree" },
  },
}

M.dap = {
    n = {
      ["<leader>dd"] = { ":call DapEnter()<CR>", "Dap start debugging" },
      ["<space>db"] = { ":lua require'dap'.toggle_breakpoint()<CR>", "Dap toggle breakpoint"},
      ["<space>dB"] = { ":lua require'dap'.toggle_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "Dap toggle conditional breakpoint"},
      ["<space>dl"] = { ":Telescope dap list_breakpoints<CR>", "Dap list breakpoints"},
      ["<space>dc"] = { ":lua require'dap'.continue()<CR>", "Dap continue"},
      ["<space>de"] = { ":lua require'dap'.terminate()<CR>", "Dap terminate"},
      ["<space>dq"] = { ":call DapExit()<CR>", "Dap exit"},
      ["<space>dp"] = { ":lua require'dap'.pause()<CR>", "Dap pause"},
      ["<space>dn"] = { ":lua require'dap'.step_over()<CR>", "Dap step over"},
      ["<space>ds"] = { ":lua require'dap'.step_into()<CR>", "Dap step into"},
      ["<space>do"] = { ":lua require'dap'.step_out()<CR>", "Dap step out"},
      ["<space>d]"] = { ":lua require'dap'.up()<CR>", "Dap frame up"},
      ["<space>d["] = { ":lua require'dap'.down()<CR>", "Dap frame down"},
      ["<space>dr"] = { ":lua require'dap'.run_last()<CR>", "Dap restart"},
      ["<space>dt"] = { ":lua require'dap'.run_to_cursor()<CR>", "Dap run to cursor"},
      ["<space>dT"] = { ":lua require'dap'.focus_frame()<CR>", "Dap focus frame"},
      ["<space>d0"] = { ":lua require'dapui'.toggle()<CR>", "Dap toggle auxiliary windows"},
      ["<space>dR"] = { ":lua require'dapui'.open({reset=true})<CR>", "Dap reset windows"},
      ["<space>dE"] = { ":lua require('dapui').eval()<CR>", "Dap eval"},
      ["<space>d:"] = { ":lua require('dapui').eval()<CR>", "Dap eval"},
    },
    v = {
      ["<space>dE"] = { "lua require('dapui').eval()<CR>", "Dap eval"},
      ["<space>d:"] = { "lua require('dapui').eval()<CR>", "Dap eval"},
    }
}

M.vimux = {
  n = {
    ["<space>:"] = {"<cmd>:call VimuxPromptCommand()<CR><c-f>:exec 'set filetype=' . g:previous_buf_filetype<CR>i", ""},
    ["<space>v:"] = {"<cmd>:call VimuxPromptCommand()<CR>", "Prompt tmux command"},
    ["<space>vo"] = {"<cmd>:call VimuxOpenRunner()<CR>", "Tmux runner"},
    ["<space>vl"] = {"<cmd>:call VimuxRunLastCommand()<CR>", "Tmux "},
    ["<space>vc"] = {"<cmd>:call VimuxCloseRunner()<CR>", "Tmux close runner"},
    ["<space>vr"] = {"<cmd>:call VimuxRunCommand('!!\\n')<CR>", "Tmux repeat previous command"},
    ["<a-enter>"] = {":call VimuxSlimeNormal()<CR>j", "Tmux line to run"},
    ["<a-v>"] = {"<cmd>:call VimuxSlimeNormal()<CR>j", "Tmux line to run"},
    ["<space>vs"] = {"<cmd>:call VimuxSlimeNormal()<CR>", "Tmux line to run"},
    ["<space>vp"] = {"<cmd>:call VimuxForRepl()<CR>", "Tmux repl"},
  },
  i = {
    ["<a-enter>"] = {"<c-o>$<c-o><cmd>:call VimuxSlimeNormal()<CR><enter>", ""},
    ["<a-v>"] = {"<c-o>$<c-o><cmd>:call VimuxSlimeNormal()<CR><enter>", ""},
  },
  v = {
    ["<A-enter>"] = {"\"vy :call VimuxSlimeVisual()<CR>", ""},
    ["<a-v>"] = {"\"vy <cmd>:call VimuxSlimeVisual()<CR>", ""},
    ["<space>vs"] = {"\"vy :call VimuxSlimeVisual()<CR>", "Tmux block to run"},
  }
}

M.browser_bookmarks = {
  n = {
    ["<leader>fb"] = { ":lua require 'browser_bookmarks'<CR>:Telescope bookmarks<CR>", "Browser bookmarks" },
  },
}

M.symbol_outline = {
  n = {
    ["<a-m>"] = {"<cmd>lua require'symbols-outline'.toggle_outline()<CR>", "Toggle symbols outline"},
    ["<Space><CR>"] = {"<cmd>lua require'symbols-outline'.toggle_outline()<CR>", "Toggle symbols outline"},
  }
}

M.fugitive = {
  plugin = true,
  n = {
    ["<Space>gs"] = {"<cmd>:Git status<CR>", "Git status"},
    ["<Space>gd"] = {"<cmd>:Gvdiffsplit<CR>", "Git diff"},
    ["<Space>gc"] = {"<cmd>:Git commit<CR>", "Git commit"},
    ["<Space>gfm"] = {"<cmd>:GMove", "Git move to"},
    ["<Space>gfr"] = {"<cmd>:GRemove<CR>", "Git remove(delete with buffer left)"},
    ["<Space>gfd"] = {"<cmd>:GDelete<CR>", "Git delete"},
    ["<Space>gl"] = {"<cmd>:let g:glog_cursor=line('.')<CR><cmd>:0Gclog<CR>", "Git current file history"},
    ["<Space>gn"] = {"<cmd>:cnext<CR>", "Git next history"},
    ["<Space>gp"] = {"<cmd>:cprev<CR>", "Git previous history"},
    ["<Space>gN"] = {"<cmd>:cprev<CR>", "Git previous history"},
    ["<Space>gr"] = {"<cmd>:Gread<CR>", "Git reset(buffer not disk)"},
    ["<Space>ga"] = {"<cmd>:Gwrite<CR>", "Git add"},
    ["<Space>gb"] = {"<cmd>:Git blame<CR>", "Git blame"},
    ["]q"] = {"<cmd>:cprev<CR>", "Git previous history"},
    ["[q"] = {"<cmd>:cnext<CR>", "Git next history"},
  },
}

M.lazygit = {
  n = {
    ["<Space>gg"] = {"<cmd>:lua require'lazygit'.lazygit()<CR>", "Lazygit"},
  },
}

M.null_ls = {
  plugin = true,
  n = {
    [",f"] = {":lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>", "format file"}
  },
}


M.languages = {
  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "lsp declaration",
    },
    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "lsp definition",
    },
    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp hover",
    },
    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "lsp implementation",
    },
    ["<leader>ct"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "lsp definition type",
    },
    ["<leader>rn"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "lsp code_action",
    },
    ["gr"] = {
      function()
        -- vim.lsp.buf.references()
        require("telescope.builtin").lsp_references()
      end,
      "lsp references",
    },
    ["gd"] = {
      function()
        -- vim.lsp.buf.definition()
        require("telescope.builtin").lsp_definitions()
      end,
      "lsp definitions",
    }
  },
  i = {
    ["<C-q>"] = {
      "<cmd>silent!lua vim.lsp.buf.signature_help()<CR>",
      -- Following function can not be silent
      -- function()
      --   vim.lsp.buf.signature_help()
      -- end,
      -- "lsp signature help",
      -- silent = true,
    },
  },
  v = {
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "lsp code_action",
    },
  }
}

  
-- ***********************************************************************
--   9. disable Nvchad default mappings
-- ***********************************************************************

-- Note that key like <A-h> and <C-h> should be with capital letter.
M.disabled = {
  n = {
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    ["<leader>wk"] = "",
    ["<leader>/"] = "",
    ["<leader>c"] = "",
    ["<leader>fb"] = "",
    ["<leader>fo"] = "",
    ["<leader>tc"] = "",
    ["<leader>wl"] = "",
    ["<leader>wK"] = "",
    ["<leader>ff"] = "",
    ["<leader>f"] = "",
    ["<leader>h"] = "",
    ["gcc"] = "",
    ["gbc"] = "",
    ["<C-h>"] = "",
    ["<leader>v"] = "",
    ["<leader>cm"] = "",
    ["]c"] = "",
    ["[c"] = "",
    ["<leader>n"] = "",
    ["<leader>rn"] = "",
    ["<leader>ra"] = "",
    ["<leader>ls"] = "",
    ["<leader>D"] = "",
    ["<leader>b"] = "",
    ["<leader>q"] = "",
  },
  i = {
    ["<C-e>"] = "",
    ["<C-b>"] = "",
  },
  v = {
    ["<leader>/"] = "",
  }
}

return M
