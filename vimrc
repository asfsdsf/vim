""" Variable g:vimrc_has_been_sourced is defined at the end of this file to judge whether it is the first time to source vimrc
""" For example, when you need to
" call airline#add_statusline_func('WindowNumber')
"
""" this function can only be added once. Hence you can
" if !exists('g:vimrc_has_been_sourced')
"     call airline#add_statusline_func('WindowNumber')
" endif 


" ***********************************************************************
" 0_Index ***************************************************************
" 1_Presettings *********************************************************
" 2_Plugins *************************************************************
" 3_Global settings *****************************************************
" 3.1_Display
" 3.2_Basic settings
" 4_Theme plugins settings **********************************************
" 4.1_Vim-Airline settings
" 4.2_Devicons settings
" 5_Function tools ******************************************************
" 6_Basic map in normal/insert/visual/command mode ******************************
" 6.1_Text navigation
" 6.2_tab map
" 6.3_buffer map
" 6.4_window map
" 6.5_Search text
" 6.6_Maps for files
" 6.7_Other map
" 6.8_Command mode keymap
" 6.9_Unite.vim
" 7_Language tools ******************************************************
" 7.1_YouCompleteMe settings
" 7.2_Coc.nvim settings
" 7.3_Tmux settings
" 7.3.1_Vimux settings
" 7.3.2_Vim-tmux-navigator settings
" 7.4_Vimspector
" 7.5_Vim-gdb
" 7.6_Format
" 7.6.1_Vim-autoformat
" 7.6.2_Neoformat
" 7.7_Ale
" 7.8_Cscope
" 8_Language settings ***************************************************
" 8.1_Html/css
" 8.2_Julia
" 8.3_Freefem++
" 8.4_Python settings
" 8.5_Matlab/octave settings
" 8.6_Javascript settings
" 8.7_C/C++ settings
" 8.8_Shell settings
" 8.9_Latex settings
" 8.9.1_Basic settings
" 8.9.2_Vimtex settings
" 9_Utilities ***********************************************************
" 9.1_Translation
" 9.2_Vim-multiple-cursor
" 9.3_Tagbar & NERDTree
" 9.4_Git
" 9.5_Fuzzy search
" 9.5.1_Fzf
" 9.5.2_Ctrlp
" 9.6_Easymotion
" 9.7_TCommentO
" 9.8_Scratch
" 9.9_snippets
" 9.10_Vim-expand-region
" 9.11_Ranger
" 9.12_Abbreviation
" 9.13_Undotree
" 9.14_Neomake
" ***********************************************************************

" ***********************************************************************
" 1_Presettings *********************************************************
    " - Set dot_file_path for neovim and vim
    " - set encoding to utf8
" ***********************************************************************

    " - Set dot_file_path for neovim and vim
    if has('nvim')
        let b:plug_path='~/.nvim/plugged'
        let b:dot_file_path='~/Software/vim/vimrc'
    else
        let b:plug_path='~/.vim/plugged'
        let b:dot_file_path='~/Software/vim/vimrc'
    endif

    set nocompatible              " be improved, required

    " - set encoding to utf8
    set encoding=utf8 

    let g:vim_plug_installed=0

    " set the runtime path to include vim-plug and initialize
    silent! call plug#begin(b:plug_path)
if exists('*plug#begin')
    let g:vim_plug_installed=1
    """ All of your Plugins must be added before the following line

" ***********************************************************************
" 2_Plugins *************************************************************
    " - utility plugins
    " - Search plugins
    " - completion plugins
    " - languages plugins
    " - git support plugins
    " - generic programming support
    " - theme / interface plugins
" ***********************************************************************

    " - utility plugins
    Plug '~/Software/vim/plugins/mysnippets/'
    Plug 'asfsdsf/toggle_maximize.vim'  " toggle maximize window
    Plug 'scrooloose/nerdtree'  " file tree
    Plug 'majutsushi/tagbar'  " file names at top bar
    " Plug 'vimwiki/vimwiki'  " Personal Wiki for Vim http://vimwiki.github.io/
    Plug 'mtth/scratch.vim'  " Unobtrusive scratch window
    Plug 'ianva/vim-youdao-translater' " translation plugin for vim  http://ianva.github.com

    " - Search plugins
    Plug 'mbbill/undotree'  " show undo history
    Plug 'junegunn/fzf.vim'  " fuzzy find
    Plug 'junegunn/fzf'  " fuzzy find together with plugin above
    Plug 'Shougo/unite.vim'  " Fuzzy search command
    Plug 'ctrlpvim/ctrlp.vim'  " Fuzzy file, buffer, mru, tag, etc finder.

    " - completion plugins
    " To recompile YouCompleteMe, run:
    " python3 install.py --clang-completer --ts-completer --java-completer
    " python3 install.py --clangd-completer --ts-completer --java-completer
    " Note that clangd is still in heavy development.(Require Vim 8.1.1875 or later)
    " in ~/.vim/plugged/YouCompleteMe for vim
    " in ~/.nvim/plugged/YouCompleteMe for nvim
    " generate .ycm_extra_conf.py file according to CMakeList.txt for YouCompleteMe
    if !empty($DISPLAY)  " if not on server
        Plug 'rdnetto/YCM-Generator',{ 'branch': 'develop'} 
    endif
    if !empty($DISPLAY)  " if not on server
        " Plug 'Valloric/YouCompleteMe'  " auto complete engine
        " sudo apt install nodejs yarnpkg
        Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Intellisense engine for Vim8 & Neovim, full language server protocol support as VSCode
        Plug 'lilydjwg/fcitx.vim'  " (auto switch chinese input method) keep and restore fcitx state when leaving/re-entering insert mode 
    endif

    " - languages plugins
    Plug 'JuliaEditorSupport/julia-vim'  " Vim support for Julia. http://julialang.org/
    Plug 'lervag/vimtex'  " A modern vim plugin for editing LaTeX files.
    Plug 'Shougo/vimproc.vim', {'do' : 'make'}  " Interactive command execution in Vim.
    Plug 'Shougo/deol.nvim'  " shell interface for NeoVim and Vim8.
    " Plug 'Shougo/vimshell.vim'  " shell interface for NeoVim and Vim8.
    Plug 'benmills/vimux'  " vim plugin to interact with tmux
    Plug 'christoomey/vim-tmux-navigator'  " Seamless navigation between tmux panes and vim splits
    " Plug 'w0rp/ale'  " Syntax checking for python
    Plug 'puremourning/vimspector'  " A multi-language debugging plugin for Vim
    if has('nvim')
        Plug 'sakhnik/nvim-gdb', { 'do': ':UpdateRemotePlugins' }
    else
        packadd termdebug
    endif
    Plug 'Chiel92/vim-autoformat'  " Provide easy code formatting in Vim by integrating existing code formatters.
    Plug 'neomake/neomake'  " Asynchronous linting and make framework for Neovim/Vim (auto async make)
    Plug 'sbdchd/neoformat' " A (Neo)vim plugin for formatting code.
    Plug 'mattn/emmet-vim'  " for html

    " - git support plugins
    Plug 'tpope/vim-fugitive' " A git wrapper for vim
    Plug 'airblade/vim-gitgutter'  " A Vim plugin which shows a git diff in the sign column and stages/previews/undoes hunks and partial hunks.
    Plug 'Xuyuanp/nerdtree-git-plugin'  " A plugin of NERDTree showing git status

    " - generic programming support
    Plug 'terryma/vim-expand-region'  " Expand region like emacs
    Plug 'wellle/targets.vim' " Vim plugin that provides additional text objects
    " Plug 'ervandew/supertab'  " perform all your vim insert mode completions with Tab
    Plug 'easymotion/vim-easymotion'  " Vim motions on speed! http://www.vim.org/scripts/script.php…
    Plug 'mg979/vim-visual-multi',  " Sublime Text style multiple selections for Vim
    " Plug 'terryma/vim-multiple-cursors'  " Sublime Text style multiple selections for Vim
    " Plug 'jiangmiao/auto-pairs' " enable an auto-close chars feature
    " Plug 'Raimondi/delimitMate'  " enable an auto-close chars feature
    Plug 'tomtom/tcomment_vim'  " extensible & universal comment vim-plugin that also handles embedded filetypes
    Plug 'tpope/vim-surround'  " surround.vim: quoting/parenthesizing made simple
    Plug 'SirVer/ultisnips'  " Track the engine.
    Plug 'honza/vim-snippets'  " Snippets are separated from the engine. Add this if you want them:

    " - Theme / Interface plugins
    " Plug 'nathanaelkane/vim-indent-guides'  " visually displaying indent levels in Vim.
    Plug 'vim-airline/vim-airline'  " beautiful bar at bottom
    Plug 'vim-airline/vim-airline-themes'  " beautiful bar at bottom
    Plug 'ryanoasis/vim-devicons'  " iconize symbols
    Plug 'morhetz/gruvbox'  "retro groove color scheme for Vim
    Plug 'mhinz/vim-startify'  " The fancy start screen for Vim.

    Plug 'sjl/badwolf'  " A color scheme for Vim, pieced together by Steve Losh.
    Plug 'tomasr/molokai' " Molokai Color Scheme for Vim
    Plug 'dracula/vim', { 'as': 'dracula' } " Dracula Theme, dark theme
    Plug 'junegunn/limelight.vim'  " adjustable color scheme
    Plug 'romainl/Apprentice' " dark, low-contrast colorscheme for Vim based on the awesome Sorcerer by Jeet Sukumaran.
    Plug 'chriskempson/base16-vim' " base16 vim theme. Consist many themes
    Plug 'AlessandroYorba/Sierra' " a vim color scheme
    Plug 'ajh17/Spacegray.vim' " Spacegray is a colorscheme for Vim loosely modeled after the spacegray theme for Xcode.
    Plug 'atelierbram/Base2Tone-vim' " colorschemes for Vim – one of the syntax-highlighting applications containing the colorschemes of Base2Tone which were based on Duotone Themes by Simurai for Atom.
    Plug 'colepeters/spacemacs-theme.vim' " A theme modelled after nashamri/spacemacs-theme


    " required
    call plug#end()
endif
" Put your non-Plugin stuff after this line

" ***********************************************************************
" 3_Global settings *****************************************************
    " - start NERDTree when Vim is started without file arguments.
" 3.1_Display
    " - show (partial) command in the last line of the screen
    " - show linenumbers
    " - enable highlighting of the current lines
    " - highlight current column
    " - have indent guides enabled by default
    " - set indent line size to one
    " - set indent line start level to 2
    " - make sure column line will be preserved when swiching buffer
    " - set 256 colors for vim
    " - set background to dark
    " - Enables 24-bit RGB color in the TUI
    " - color conflict with TERMINOLOGY
    " - function to toggle between light and dark theme
    " - access colors present in 256 colorspace
    " - set color scheme
" 3.2_Basic settings
    " - set indentation
    " - enable mouse
    " - conflict config for nvim and vim
    " - Function to check that whether vim-plug is installed and warn if not
    " - turn off key timeout
    " - set alt map
    " - smart case for / search
    " - highlight all search matches
    " - highlight the next match while you're still typing out your search pattern
    " - set more visual hints in command-line mode
    " - viminfo settings(saved infomation when restart vim)
    " - indention Options
    " - smart tab and expand tab
    " - enable hidden buffers
    " - make scroll leave a margin for 3 lines
    " - set updatetime to 1 second.This is used for CursorHold event
" ***********************************************************************

    " - start NERDTree when Vim is started without file arguments.
    autocmd StdinReadPre * let s:std_in=1
    " This comflict with vim-startify
    " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" ***********************************************************************
" 3.1_Display
" ***********************************************************************
    " - show (partial) command in the last line of the screen
    set showcmd                          "show key strokes

    " - show linenumbers
    set number relativenumber
    set ruler " Always show cursor position

    " - enable highlighting of the current lines
    set cursorline
    " - highlight current column
    set cursorcolumn

    " - have indent guides enabled by default
    let g:indent_guides_enable_on_vim_startup = 1
    " - set indent line size to one
    let g:indent_guides_guide_size = 1
    " - set indent line start level to 2
    let g:indent_guides_start_level=2

    " - make sure column line will be preserved when swiching buffer
    set nostartofline

    " - set 256 colors for vim
    set t_Co=256
    " - set background to dark
    set background=dark

    " - Enables 24-bit RGB color in the TUI
    if (has("termguicolors"))
      set termguicolors
    endif

    " - color conflict with TERMINOLOGY
    if exists("$TERMINOLOGY")
        set notermguicolors
    endif

    " - function to toggle between light and dark theme
    function! ToggleTheme()
        if !s:CheckWarnVimPlugInstalled()
            return
        end
        if (&background=='dark')
            set background=light
            AirlineTheme base16_monokai
            exec 'colorscheme ' . g:light_color_scheme
        else
            set background=dark
            AirlineTheme hybrid
            exec 'colorscheme ' . g:dark_color_scheme
        endif
    endfunction

    " - access colors present in 256 colorspace
    let base16colorspace=256

    " - set color scheme
    " colorscheme spacegray
    " colorscheme spacemacs-theme
    let g:gruvbox_contrast_light = 'soft'
    let g:dark_color_scheme='gruvbox'
    let g:light_color_scheme='gruvbox'
    if g:vim_plug_installed
        exec 'colorscheme ' . g:dark_color_scheme
    endif
    " colorscheme gruvbox

    let g:spacegray_underline_search = 1
    let g:spacegray_italicize_comments = 1

    " let g:gruvbox_contrast_dark = 'hard'

" ***********************************************************************
" 3.2_Basic settings
" ***********************************************************************

    " - set indentation
    set foldmethod=indent
    set foldnestmax=10
    set nofoldenable

    " - enable mouse
    set mouse=a

    " - conflict config for nvim and vim
    if(!has("nvim"))
        " Use system clipboard
        set clipboard^=unnamed,unnamedplus
        " Prevent Vim from clearing the clipboard on exit
        autocmd VimLeave * call system("xsel -ib", getreg('+'))
        " conlict with tmux(color will be gone without this)
        if exists('+termguicolors')
            let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
            set termguicolors
        endif
    else
        set clipboard+=unnamedplus
    endif

    " - Function to check that whether vim-plug is installed and warn if not
    function! s:CheckWarnVimPlugInstalled()
        if g:vim_plug_installed
            return 1
        else 
            echohl WarningMsg
            echomsg "vim-plug is not installed."
            echohl None
            finish
            return 0
        endif
    endfunction

    " - turn off key timeout
    if has('nvim')
        set notimeout
    else

    " - set alt map
    function! Terminal_MetaMode(mode)
        set ttimeout
        if $TMUX != ''
            set ttimeoutlen=30
        elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
            set ttimeoutlen=80
        endif
        if has('nvim') || has('gui_running')
            return
        endif
        function! s:metacode(mode, key)
            if a:mode == 0
                exec "set <M-".a:key.">=\e".a:key
            else
                exec "set <M-".a:key.">=\e]{0}".a:key."~"
            endif
        endfunc
        for i in range(10)
            call s:metacode(a:mode, nr2char(char2nr('0') + i))
        endfor
        for i in range(26)
            call s:metacode(a:mode, nr2char(char2nr('a') + i))
            call s:metacode(a:mode, nr2char(char2nr('A') + i))
        endfor
        if a:mode != 0
            for c in [',', '.', '/', ';', '[', ']', '{', '}']
                call s:metacode(a:mode, c)
            endfor
            for c in ['?', ':', '-', '_']
                call s:metacode(a:mode, c)
            endfor
        else
            for c in [',', '.', '/', ';', '{', '}']
                call s:metacode(a:mode, c)
            endfor
            for c in ['?', ':', '-', '_']
                call s:metacode(a:mode, c)
            endfor
        endif
    endfunc
     " Comment following line to disable meta key as alt
    call Terminal_MetaMode(0)

    endif



    " - smart case for / search
    set ignorecase
    set smartcase

    " - highlight all search matches
    :set hlsearch

    " - highlight the next match while you're still typing out your search pattern
    :set hlsearch incsearch

    " - set more visual hints in command-line mode
    set wildmenu

    " - viminfo settings(saved infomation when restart vim)
    " maximum number of lines saved for each register would be 50, the maximum size of saved items is 10 KB and the effect of 'hlsearch' is disabled when loading the viminfo file.
    set viminfo='500,<50,s10,h

    " - indention Options
    set autoindent " New lines inherit the indentation of previous lines
    set expandtab " Convert tabs to spaces
    set shiftwidth=4 " When shifting, indent using four spaces
    set tabstop=4 " Indent using four spaces

    " - smart tab and expand tab
    set smarttab
    set expandtab

    " - enable hidden buffers
    set hidden

    " - make scroll leave a margin for 3 lines
    set scrolloff=3

    " - set updatetime to 1 second.This is used for CursorHold event
    set updatetime=1000

" ***********************************************************************
" 4_Theme plugins settings **********************************************
" 4.1_Vim-Airline settings
    " - add window number in front of the airline
    " - call those only once and only when vim-plug is installed(for airline)
" 4.2_Devicons settings
" ***********************************************************************


" ***********************************************************************
" 4.1_Vim-Airline settings
" ***********************************************************************
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline_theme='hybrid'
    let g:hybrid_custom_term_colors = 1
    let g:hybrid_reduced_contrast = 1


    " - add sign M to show whether the window is maximized
    function! MaxmizedSign(...)
        let builder = a:1
        let context = a:2
        call builder.add_section('airline_b', '%{MaxmizedSignText()}')
        return 0
    endfunction
    function!MaxmizedSignText()
        if g:isToggledVertically || g:isToggledHorizontally
            return 'M'
        else
            return ''
        endif

    endfunction

    " - add window number in front of the airline
    function! WindowNumber(...)
        let builder = a:1
        let context = a:2
        call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
        return 0
    endfunction

    " - call those only once and only when vim-plug is installed(for airline)
    if !exists('g:vimrc_has_been_sourced') && g:vim_plug_installed
        call airline#add_statusline_func('WindowNumber')
        call airline#add_inactive_statusline_func('WindowNumber')
        call airline#add_statusline_func('MaxmizedSign')
    endif

" ***********************************************************************
" 4.2_Devicons settings
" ***********************************************************************
    let g:webdevicons_conceal_nerdtree_brackets = 1
    let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

" ***********************************************************************
" 5_Function tools ******************************************************
    " - keymap for open_file_help file(e.g. Used to OpenTodoFile)
    " - command to open a file to write python code and then output to current file
    " - open and edit find actions file which provide useful keymaps.(Use <Space>aa to
    " - open and edit vim_TODO file
    " - open and edit flake8 config file
    " - map to open url under cursor
    " - command to show difference between buffer with saved file
    " - command to open files under some important directories
    " - command to compare current file with clipboard
" ***********************************************************************

    " - keymap for open_file_help file(e.g. Used to OpenTodoFile)
    autocmd BufRead,BufNewFile  $HOME/Software/vim/open_file_help.sh map <buffer> <esc> :bd!<CR>
    autocmd BufRead,BufNewFile  $HOME/Software/vim/open_file_help.sh imap <buffer> <c-c> <esc>:bd!<CR>
    autocmd BufRead,BufNewFile  $HOME/Software/vim/open_file_help.sh imap <buffer> <c-h> <c-w><c-w>
    autocmd BufRead,BufNewFile  $HOME/Software/vim/open_file_help.sh inoremap <buffer> <CR> <c-o>:stopinsert<CR>:let mycurf=expand("<cfile>")<CR>:bd!<CR>:execute("e ".mycurf)<CR>

    " - command to open a file to write python code and then output to current file
    function! s:Python_print()
        if expand('%:p')==$HOME."/Software/vim/python_for_vim.py"
            wq
            r !python $HOME/Software/vim/python_for_vim.py
        else
            vsplit $HOME/Software/vim/python_for_vim.py
            execute "normal!gg\"pdG"
    "        echo "press P to use last python file"
        endif
    endfunction
    com! PythonPrint call s:Python_print()

    " - open and edit find actions file which provide useful keymaps.(Use <Space>aa to
    " access the keymaps)
    com! OpenFindActionsFile 12sp ~/Software/vim/vim_tip/find_actions

    " - open and edit vim_TODO file
    com! OpenTodoFile 12sp ~/Software/vim/TODO

    " - open and edit flake8 config file
    com! OpenFlake8Config 12sp ~/.config/flake8

    " - map to open url under cursor
    function! OpenUrlUnderCursor()
        let path="/usr/bin/google-chrome-stable"
        execute "normal BvEy"
        let url=matchstr(@0, '[a-z]*:\/\/[^ >,;]*')
        if url != ""
            " silent exec "!open -a ".path." '".url."'" | redraw! 
            silent exec "!/usr/bin/google-chrome-stable '".url."'&" | redraw!
            echo "opened ".url
        else
            echo "No URL under cursor."
        endif
    endfunction
    nmap <c-c><c-o> :call OpenUrlUnderCursor()<CR>



    " - command to show difference between buffer with saved file
    function! s:DiffWithSaved()
      let filetype=&ft
      diffthis
      vnew | r # | normal! 1Gdd
      diffthis
      exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
    endfunction
    com! DiffSaved call s:DiffWithSaved()

    " - command to open files under some important directories
    function! s:OpenDirectoryFile(dir_path)
        12sp $HOME/Software/vim/open_file_help.sh
        exec "normal! \<c-w>J"
        put =a:dir_path
        exec "normal!k\"pdd"
        startinsert!
    endfunction
    com!OpenSoftwareInstallRecord call s:OpenDirectoryFile('~/Documents/Notes/software_installation_record')
    com!OpenMySnippets call s:OpenDirectoryFile('~/Software/vim/plugins/mysnippets/UltiSnips')
    com!OpenProgrammingNotes call s:OpenDirectoryFile('~/Documents/Notes/programming')
    com!OpenCustomCommand call s:OpenDirectoryFile('~/Programming/shell/command')
    com!OpenBashComplete call s:OpenDirectoryFile('~/Programming/shell/autocomplete/my_complete')
    com!OpenZshComplete call s:OpenDirectoryFile('~/Software/zsh/completion')
    com!OpenGraduateStudy call s:OpenDirectoryFile('~/Documents/learn/study')

    " - command to compare current file with clipboard
    function! s:Compared_with_clipboard()
        diffthis
        vnew ~/Software/vim/clipboard
        execute 'normal!gg"_dG"+P'
        execute 'w'
        diffthis
    endfunction
    com!CompareClipboard call s:Compared_with_clipboard()
    " exit diff mode after closing clipboard
    autocmd QuitPre ~/Software/vim/clipboard :diffoff
    " auto update difference
    autocmd TextChanged ~/Software/vim/clipboard :diffupdate

" ***********************************************************************
" 6_Basic map in normal/insert/visual/command mode ******************************
" 6.1_Text navigation
    " - map movement in insert mode
    " - map create new line in insert mode
    " - map C-a/C-e to begin/end of the line in insert mode
    " - map C-y to paste
    " - map SPC ty to toggle paste mode
    " - map gm to go to pair
    " - map H/L to move to begin/end of the line
    " - goto tags (symbols) in current file finder mapping
    " - goto tags (symbols) in all files finder mapping
    " - recent changes in all buffers
    " - recent changes in current buffer
    " - recent jumps in current buffer
" 6.2_tab map
    " - map gt/gT to move to next/prev tab
    " - map to create tab
    " - map to close tab
" 6.3_buffer map
    " - map to go to next/prev buffer
    " - map to go to last buffer
    " - map to close buffer
    " - map to show message buffer
    " - map to show buffers
    " - map to go to Scratch buffer
    " - map to close buffe and window
    " - map to go to nth buffer
" 6.4_window map
    " - map to move to down/up/left/right window
    " - map to move window position
    " - map to split window
    " - map to go to previous window
    " - map to equal all windows
    " - map to close current window
    " - map to close current window and buffer
    " - map to close other windows
    " - map to resize window
    " - map to go to nth window
    " - prevent conflict(type mistake) with tmux
" 6.5_Search text
    " - map C-h to replace
    " - map SPC / to search current folder
    " - map to search lines in all buffers
    " - map C-f search inside current buffer
    " - map * to search selection in visual mode
    " - don't copy when using c and C to change text
" 6.6_Maps for files
    " - map C-s to save buffer in insert mode(use C-s in vim will freeze)
    " - map to go to recent file
    " - open file under the cursor with default system software
    " - open the folder containing current file
    " - open current file with default system software
    " - open the terminal with current file path as working directory
    " - map gf to go to filename under cursor
    " - map to open file by path
    " - map to open file/git file in directory/git project
    " - map to open file in project
    " - map to refresh buffer file
    " - copy current file path
    " - edit file whose path is copied
    " - map SPC fvd to go to dot file(this file)
    " - map SPC fvR to source dot file
" 6.7_Other map
    " - map SPC SPC to run command
    " - insert dividing line
    " - map to switch theme
    " - map to zoom in/out
    " - map to move line up/down
    " - map to run python and output to current line
    " - function to save layout
    " - function to load layout
    " - map to save layout
    " - map to load layout
    " - map to quit
    " - map to describe key
    " - map to change working directory to current git project/current file
    " - map to toggle wrap
    " - map to find actions
    " - map to open current file by gedit
    " - map to show undo tree
    " - map to open built-in terminal
    " - map ,er to execute vim line/selected region in normal/visual mode
" 6.8_Command mode keymap
    " - command-line window enter insert mode automatically
    " - set filetype to be the same with previous file when searching 
    " - set filetype to be the same with previous file when replacing in command-line mode
    " - execute the command under the cursor and then have the command-line window open again
" 6.9_Unite.vim
" ***********************************************************************

    " map! map to insert and command-line mode

    " - map movement in insert mode
    noremap! <c-b> <left>
    noremap! <c-j> <down>
    noremap! <c-k> <up>
    noremap! <c-f> <right>
    noremap! <c-h> <left>
    noremap! <c-l> <right>
    noremap! <A-b> <c-left>
    noremap! <A-f> <c-right>
    noremap! <A-h> <c-left>
    noremap! <A-l> <c-right>

    " - map create new line in insert mode
    inoremap <A-j> <c-o>o
    inoremap <A-k> <c-o>O

    " - map C-y to paste
    noremap! <c-y> <c-r>+

    " - map SPC ty to toggle paste mode
    nnoremap <space>tp :call g:TogglePaste()<cr>
    if !exists('g:in_paste_mode')
        let g:in_paste_mode=0
    endif
    function! g:TogglePaste()
        if g:in_paste_mode
            set nopaste
            let g:in_paste_mode=0
            echo "In nopaste mode now"
        else
            set paste
            let g:in_paste_mode=1
            echo "In paste mode now"
        endif
    endfunction

    " - map C-a/C-e to begin/end of the line in insert mode
    inoremap <c-a> <c-o>^
    inoremap <c-e> <c-o>$
    cnoremap <c-a> <home>
    cnoremap <c-e> <end>

    " - map gm to go to pair
    nnoremap gm %
    vnoremap gm %

    " - map H/L to move to begin/end of the line
    nnoremap H ^
    nnoremap L $
    vnoremap H ^
    vnoremap L $

    " - goto tags (symbols) in current file finder mapping
    nnoremap ,gt :CtrlPBufTag<CR>
    " - goto tags (symbols) in all files finder mapping
    nnoremap ,gT :CtrlPBufTagAll<CR>
    " - recent changes in all buffers
    nnoremap ,gC :CtrlPChangeAll<CR>
    " - recent changes in current buffer
    nnoremap ,gc :SearchChanges!<CR>
    nnoremap <A-c> :SearchChanges!<CR>
    " - recent jumps in current buffer
    nnoremap ,gj :JumpsResults!<CR>

" ***********************************************************************
" 6.2_tab map
" ***********************************************************************

    " - map gt/gT to move to next/prev tab
    nnoremap <Space>tl gt
    nnoremap <Space>th gT
    " - map to create tab
    nnoremap <Space>tn :tabnew<CR>
    " - map to close tab
    nnoremap <Space>tc :tabclose<CR>

" ***********************************************************************
" 6.3_buffer map
" ***********************************************************************

    " - map to go to next/prev buffer
    nnoremap <A-n> :bn<CR>
    nnoremap <A-p> :bp<CR>
    nnoremap <Space>bn :bn<CR>
    nnoremap ]b :bn<CR>
    nnoremap <Space>bp :bp<CR>
    nnoremap [b :bp<CR>

    " - map to go to last buffer
    nnoremap <Space><Tab> :b#<CR>
    function!CloseBuffer()
        let buf_num = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
        if buf_num <= 1
            if exists(":Startify")
                Startify
            else
                enew
            endif
        else
            bp
            bd#
        endif
    endfunction
    " - map to close buffer
    nnoremap <Space>bd :call CloseBuffer()<CR>
    " - map to show message buffer
    nnoremap <Space>bm :messages<CR>

    " - map to show buffers
    " nnoremap <Space>bb :CtrlPBuffer<CR>
    nnoremap <Space>bb :FzfBuffers!<CR>

    " - map to go to Scratch buffer
    nnoremap <Space>bs :Scratch<CR>

    " - map to close buffe and window
    nnoremap <Space>bx :call CloseMaximize()<CR>:bp<cr>:silent! exec "bd #"<CR>:close<CR>

    " - map to go to nth buffer
    " Goto (nth_add_1 - 1)  buffer shown in top bar
    function! g:GotoNthBuffer(nth_add_1)
        " let g:previous_buf_name=bufname("#")
        bfirst
        exec a:nth_add_1 . "bn"
        " let g:current_buf_name=bufname("%")
        " exec "buffer " . g:previous_buf_name
        " exec "buffer " . g:current_buf_name
    endfunction
    nnoremap <Space>b1 :bfirst<CR>
    nnoremap <Space>b2 :call g:GotoNthBuffer("1")<CR>
    nnoremap <Space>b3 :call g:GotoNthBuffer("2")<CR>
    nnoremap <Space>b4 :call g:GotoNthBuffer("3")<CR>
    nnoremap <Space>b5 :call g:GotoNthBuffer("4")<CR>
    nnoremap <Space>b6 :call g:GotoNthBuffer("5")<CR>
    nnoremap <Space>b7 :call g:GotoNthBuffer("6")<CR>
    nnoremap <Space>b8 :call g:GotoNthBuffer("7")<CR>
    nnoremap <Space>b9 :call g:GotoNthBuffer("8")<CR>

" ***********************************************************************
" 6.4_window map
" ***********************************************************************

    " - map to move to down/up/left/right window
    nnoremap <A-J> <C-W>j
    nnoremap <A-K> <C-W>k
    nnoremap <A-L> <C-W>l
    nnoremap <A-H> <C-W>h
    nnoremap <silent> <Space>wh :call CloseMaximize()<CR><C-w>h
    nnoremap <silent> <Space>wj :call CloseMaximize()<CR><C-w>j
    nnoremap <silent> <Space>wk :call CloseMaximize()<CR><C-w>k
    nnoremap <silent> <Space>wl :call CloseMaximize()<CR><C-w>l

    " - map to move window position
    nnoremap <Space>wH :call CloseMaximize()<CR><C-w>H
    nnoremap <Space>wJ :call CloseMaximize()<CR><C-w>J
    nnoremap <Space>wK :call CloseMaximize()<CR><C-w>K
    nnoremap <Space>wL :call CloseMaximize()<CR><C-w>L

    " - map to split window
    nnoremap <Space>w/ :call CloseMaximize()<CR>:vs<CR>
    nnoremap <Space>w- :call CloseMaximize()<CR>:sp<CR>
    " map <ESC> to exit insert mode in shell buffer
    " tnoremap <ESC>   <C-\><C-n>

    " - map to go to previous window
    nnoremap <Space>ww :call CloseMaximize()<CR><C-w>w
    " - map to equal all windows
    nnoremap <Space>w= :call CloseMaximize()<CR><C-w>=
    " - map to close current window
    nnoremap <Space>wd :call CloseMaximize()<CR>:close<CR>
    " - map to close current window and buffer
    nnoremap <Space>wx :call CloseMaximize()<CR>:bp<cr>:silent! exec "bd #"<CR>:close<CR>
    " - map to close other windows
    nnoremap <Space>wo :call CloseMaximize()<CR><C-w><C-o>

    " - map to resize window
    nnoremap <c-down>  2<C-w>-
    nnoremap <c-up>    2<C-w>+
    nnoremap <c-left>  2<C-w><
    nnoremap <c-right> 2<C-w>>

    " - map to go to nth window
    nnoremap <Space>1  :call CloseMaximize()<CR>1<C-w><C-w>
    nnoremap <Space>2  :call CloseMaximize()<CR>2<C-w><C-w>
    nnoremap <Space>3  :call CloseMaximize()<CR>3<C-w><C-w>
    nnoremap <Space>4  :call CloseMaximize()<CR>4<C-w><C-w>
    nnoremap <Space>5  :call CloseMaximize()<CR>5<C-w><C-w>
    nnoremap <Space>6  :call CloseMaximize()<CR>6<C-w><C-w>
    nnoremap <Space>7  :call CloseMaximize()<CR>7<C-w><C-w>
    nnoremap <Space>8  :call CloseMaximize()<CR>8<C-w><C-w>
    nnoremap <Space>9  :call CloseMaximize()<CR>9<C-w><C-w>

    " - prevent conflict(type mistake) with tmux
    nnoremap <c-a> l

    " 6.5_Search text

    " - map SPC / to search current folder
    nnoremap <Space>/  :Ag!<CR>
    vnoremap <Space>/  "vy:exec "Ag!" . escape(@v,'/\()*+?[]$^<bar>')<CR>
    " - map to search lines in all buffers
    nnoremap <Space>b/ :Lines<CR>
    " - map C-f search inside current buffer
    nnoremap <c-f>  :w<CR>:AgCurrentFile!<CR>
    " search inside current buffer
    nnoremap <c-f>  :BLines<CR>

    " - map * to search selection in visual mode
    vnoremap * "vy/\V<C-R>=substitute(escape(@v,'/\'),'\n','\\n','g')<CR><CR>

    " - map C-h to replace
    nnoremap <A-H> :%s//gc<left><left><left>
    nnoremap <c-h> :%s//gc<left><left><left>
    xnoremap <c-h> :s//gc<left><left><left>


    " - don't copy when using c and C to change text
    nnoremap c "9c
    nnoremap C "9C
    nnoremap x "9x
    nnoremap X "9X
    vnoremap P "_dP

" ***********************************************************************
" 6.6_Maps for files
" ***********************************************************************

    " - map C-s to save buffer in insert mode(use C-s in vim will freeze)
    inoremap <c-s> <c-o>:update<CR>

    " - map SPC f s to save buffer with sudo privilige in vim(not neovim)
    if !has('nvim')
        nnoremap <space>fs :w !sudo tee %<CR>
    endif

    " - map to go to recent file
    nnoremap <Space>fr :FzfMrf!<CR>

    " - open file under the cursor with default system software
    nnoremap <Space>fO :!cd %:p:h && xdg-open "<cfile>" & <CR>
    " - open the folder containing current file
    nnoremap <Space>fd :!nautilus %:p:h &<CR>
    " - open current file with default system software
    nnoremap <Space>fo :!cd %:p:h && xdg-open %:p & <CR>
    " - open the terminal with current file path as working directory
    nnoremap <Space>ft :silent! !gnome-terminal --working-directory=%:p:h &<CR>
    if exists("$TERMINOLOGY")
        nnoremap <Space>ft :silent! !terminology -d %:p:h &<CR>
    endif

    " - map gf to go to filename under cursor
    nnoremap <c-c><c-o> gf

    " - map to open file by path
    function! g:OpenFileByPath()
        12sp $HOME/Software/vim/open_file_help.sh
        exec "normal! \<c-w>J"
        r!pwd
        exec "normal!k\"pdd"
        startinsert!
    endfunction
    nnoremap <Space>ff :call g:OpenFileByPath()<CR>
    " - map to open file/git file in directory/git project
    nnoremap <Space>pf :GFiles!<CR>
    " - map to open file in project
    nnoremap <Space>pF :Files!<CR>

    " - map to refresh buffer file
    nnoremap <f5> :e<CR>

    " - copy current file path
    " nnoremap <Space>fy :silent exec '!printf ' . expand('%:p') . ' <bar> xclip -selection clipboard'<CR>
    nnoremap <Space>fy :let @+ = expand("%:p")<CR>
    nnoremap <Space>yy :let @+ = expand("%:p")<CR>
    " - edit file whose path is copied
    nnoremap <Space>fe :exec "e " . expand(@+)<CR>
    nnoremap <Space>ye :exec "e " . expand(@+)<CR>
    nnoremap <Space>pp :exec "e " . expand(@+)<CR>

    " - map SPC fvd to go to dot file(this file)
    execute "com! OpenVimrcDotFile e " . b:dot_file_path
    nnoremap <Space>fvd :OpenVimrcDotFile<CR>
    " - map SPC fvR to source dot file
    execute "nnoremap <Space>fvR :source " . b:dot_file_path . "<CR>"


    " nnoremap <Space>ff :CtrlP %<CR>
    " nnoremap <Space>ss :CtrlPLine %<CR>  " Use <c-f> instead

" ***********************************************************************
" 6.7_Other map
" ***********************************************************************

    " - map SPC SPC to run command
    if g:vim_plug_installed
        nnoremap <Space><Space> :Commands<CR>
    else
        nnoremap <Space><Space> :<c-f>
    endif

    " - insert dividing line
    nnoremap <Space>id :r !echo "***********************************************************************"<CR>:TComment<CR>5l

    " - map to switch theme
    nnoremap <Space>Tn :call ToggleTheme()<CR>

    " - map to zoom in/out
    nnoremap <Space>z+ zR
    nnoremap <Space>z- zM

    " - map to move line up/down
    nnoremap ]e        :move +1<CR>
    nnoremap [e        :move -2<CR>

    " - map to run python and output to current line
    nnoremap <Space>mcc :w<CR>:!python %<CR>

    " - function to save layout
    let g:custom_layout_path="~/Software/vim/session"
    let g:custom_layout_manual_path="~/Software/vim/session/manual-saving"
    function! SaveLayout(toInputName)
        cd %:h
        silent! Gcd
        if a:toInputName
            call inputsave()
            let s:input_layout_name=input('Please input layout(session) name: ')
            call inputrestore()
            let s:layout_path=g:custom_layout_manual_path . "/" . s:input_layout_name . ".vim"
        else
            let s:layout_dir=g:custom_layout_path . system("printf " . getcwd())
            silent exec "!mkdir -p " . s:layout_dir
            let s:layout_path=s:layout_dir . "/Session.vim"
        endif
        exec "mksession! " . s:layout_path
    endfunction

    " - function to load layout
    function! LoadLayout(toInputName)
        if a:toInputName
            12sp $HOME/Software/vim/open_file_help.sh
            exec "normal! \<c-w>J"
            exec "r!echo " . g:custom_layout_manual_path
            exec "normal!k\"pdd"
            startinsert!

            iunmap <buffer> <enter>
            inoremap <buffer> <enter> <c-o>:stopinsert<CR>:let mycurf=expand("<cfile>")<CR>:bd!<CR>:execute("source ".mycurf)<CR>
        else
            let s:layout_dir=g:custom_layout_path . system("printf " . getcwd())
            let s:layout_path=s:layout_dir . "/Session.vim"
            exec "source " . s:layout_path

        endif
    endfunction
    " - map to save layout
    nnoremap <Space>ls :call SaveLayout(0)<CR>
    nnoremap <Space>lS :call SaveLayout(1)<CR>
    " - map to load layout
    nnoremap <Space>ll :call LoadLayout(0)<CR>
    nnoremap <Space>lL :call LoadLayout(1)<CR>

    " - map to quit
    nnoremap <Space>qq :qa<CR>

    " - map to describe key
    nnoremap <Space>hdk :Maps<CR>

    " - map to show snippets
    nnoremap <Space>hds :Snippets<CR>

    " - map to change working directory to current git project/current file
    nnoremap <Space>cd :cd %:h<CR>:silent! Gcd<CR>

    " - map to toggle wrap
    function s:Toggle_Wrap()
        if &wrap
            windo set wrap!
        else
            windo set wrap
        endif
    endfunction
    " com!ToggleWrap windo set wrap
    com!ToggleWrap call s:Toggle_Wrap()
    nnoremap <Space>tw :ToggleWrap<CR>
    " - map to find actions
    nmap <space>aa :FindActions<CR>
    " - map to open current file by gedit
    nmap <space>ag :!gedit %<CR>
    " - map to show undo tree
    nmap <space>au :UndotreeToggle<CR>
    " - map to open built-in terminal
    if has('nvim')
        nnoremap <space>as :terminal<CR>
    else
        nnoremap <space>as :vertical terminal ++curwin<CR>
    endif

    " - map ,er to execute vim line/selected region in normal/visual mode
    autocmd FileType vim vnoremap <buffer> ,er "vy :@v<CR>
    autocmd FileType vim nnoremap <buffer> ,er :exec getline(".")<CR>

" ***********************************************************************
" 6.8_Command mode keymap
" ***********************************************************************

    " - command-line window enter insert mode automatically
    " after :/?, type <c-f> to edit
    au CmdwinEnter [:/?]  startinsert

    " - set filetype to be the same with previous file when searching 
    "   because autocomplete will search all buffer with same filetype 
    au BufEnter * let g:previous_buf_filetype=&filetype
    au CmdwinEnter [/?]  exec "set filetype=" . g:previous_buf_filetype

    function! s:ChangeFileTypeIfReplacing()
        if stridx(getline('.'),"s/") >= 0
            exec "set filetype=" . g:previous_buf_filetype
        endif
    endfunction


    " - set filetype to be the same with previous file when replacing in command-line mode
    au CmdwinEnter [:] call s:ChangeFileTypeIfReplacing()

    " - execute the command under the cursor and then have the command-line window open again
    autocmd CmdwinEnter * map <buffer> <F5> <CR>q:

    " Debug mode auto command
    " au CmdwinEnter [>] do something

" ***********************************************************************
" 6.9_Unite.vim
" ***********************************************************************

    " nnoremap <Space><Space>  :Unite -start-insert -buffer-name=command  command<CR>
    function! s:UniteSettings()
        au InsertLeave <buffer> :UniteClose
        imap <buffer> <TAB>   <Plug>(unite_select_next_line)
        imap <buffer> <s-TAB>   <Plug>(unite_select_previous_line)
    endfunction

    au FileType unite call s:UniteSettings()
    " inoremap <buffer><silent> <c-g> <Plug>(unite_exit)

" ***********************************************************************
" 7_Language tools ******************************************************
" 7.1_YouCompleteMe settings
    " - map go to for YouCompleteMe
    " - map FixIt for YouCompleteMe
    " - map restart YouCompleteMe server
    " - map generate YouCompleteMe config
    " - disable c-y to stop completion to prevent comfliction with paste using <c-y>
    " - jump to for YouCompleteMe
    " - open keyword completion for YouCompleteMe
    " - blacklist for youcompleteme
    " - disable prompt to ask whether load .ycm_extra_conf.py file
    " - let clangd fully control code completion
    " - use installed clangd, not YCM-bundled clangd which doesn't get updates.
    " - python completion settings
" 7.2_Coc.nvim settings
    " - coc plugins list
    " - add coc status to statusline below
    " - map <ta>/<s-tab> to go to next/prev snippet
    " - disable auto pair of < for c,cpp files for coc.nvim
    " - coc language server settings for kotlin
    " - let VimspectorPrompt buffer use omni completion
    " - coc user settings 
    " - highlight the symbol and its references when holding the cursor.
    " - scroll popup window with <c-d> and <c-u> in insert mode
    " - map <up> and <down> and <c-u> and <c-d> to scroll in coc.nvim floating windows such as documentation window
    " - map <tab> for trigger completion and navigate to the next complete item
    " - map tab and s-tab for trigger completion with characters ahead and navigate.
    " - map <c-n> to trigger completion.
    " - map <c-p> to toggle show signature help
    " - map <c-j> to jump to the floating window in normal mode
    " - map to navigate diagnostic
    " - map goTo code navigation.
    " - map K to show documentation in preview window.
    " - map function and class text objects such as select inside function vif
    " - map to generate clangd compile_commands.json according to Cmakelists.txt
    " - map to restart coc server
    " - map to change python interpreter
    " - map to run coc command
    " - map to show structure with the help of coc
    " - map to show coc lists
" 7.3_Tmux settings
" 7.3.1_Vimux settings
    " - function to run to another window if in tmux mode. Else run directly
    " - set VimuxReplDefaultFiletype for repl
    " - map to call some tmux command
    " - function to run visual region in another tmux pane
    " - function to show python doc of register v
    " - function to run current line in another tmux pane
    " - map to run visual region in another tmux pane
    " - toggle using vim for repl in another pane
    " - map to toggle using vim for repl in another pane
    " - function to change another pane's directory for tmux
" 7.3.2_Vim-tmux-navigator settings
    " - Disable default vim-tmux-navigator mappings
    " - map to navigate for both tmux and vim
    " - function to maximize considering all vim panes and tmux panes
    " - function to close maximize
    " - map to toggle maximize tmux
" 7.4_Vimspector
    " - run following to install
    " - vimspector gadgets (debugger program)
    " - map <tab> for auto completion in Vimspector console (<c-x><c-o> is omni commpletion)
    " - map for debug mode of vimspector
    " - map to copy .vimspector.json file to current directory for further config in project directory.
" 7.5_Vim-gdb
" 7.6_Format
" 7.6.1_Vim-autoformat
" 7.6.2_Neoformat
" 7.7_Ale
" 7.8_Cscope
    " - use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    " - check cscope for definition of a symbol before checking ctags: 
    " - add any cscope database in current directory
    " - show msg when any other cscope db added
    " - mappings for cscope
" ***********************************************************************


" ***********************************************************************
" 7.1_YouCompleteMe settings
" ***********************************************************************

    " - map go to for YouCompleteMe
    nnoremap <Space>yb :YcmCompleter GoTo<CR>
    nnoremap <Space>yB :YcmCompleter GoToDeclaration<CR>
    nnoremap <Space>yd :YcmCompleter GetDoc<CR>

    " - map FixIt for YouCompleteMe
    nnoremap <Space>yf :YcmCompleter FixIt<CR>

    " - map restart YouCompleteMe server
    nnoremap <Space>yr :YcmRestartServer<CR>

    " - map generate YouCompleteMe config
    " Note here replace of FlagsForFile is due to use of clangd.
    nnoremap <Space>yg :![[ -e CMakeLists.txt ]] && rm .ycm_extra_conf.py<CR>:YcmGenerateConfig<CR>:!sed -i 's/FlagsForFile/Settings/g' .ycm_extra_conf.py<CR>
    " <c-e> :cancel completion

    " - jump to for YouCompleteMe
    autocmd FileType c,cpp,python,java,javascript nnoremap <buffer> <c-b> :YcmCompleter GoTo<CR>


    " - disable c-y to stop completion to prevent comfliction with paste using <c-y>
    let g:ycm_key_list_stop_completion = ['']

    if g:vim_plug_installed
        " To recompile YouCompleteMe:
        " in ~/.vim/plugged/YouCompleteMe for vim
        " in ~/.nvim/plugged/YouCompleteMe for nvim
        " python3 install.py --clang-completer  # for nvim
        " python3 install.py --clangd-completer  # for vim

        " To generate .ycm_extra_conf.py according to CMakeList.txt, run:
        " :YcmGenerateConfig

        let g:ycm_always_populate_location_list = 1
        " - open keyword completion for YouCompleteMe
        let g:ycm_seed_identifiers_with_syntax=1
        " let g:ycm_python_binary_path = 'python3'
        " - blacklist for youcompleteme
        let g:ycm_filetype_blacklist = {
                \ 'tagbar' : 1,
                \ 'gitcommit' : 1,
                \ 'unite' : 1,
                \}
        let g:ycm_autoclose_preview_window_after_completion = 1

        " - disable prompt to ask whether load .ycm_extra_conf.py file
        " (automatically load .ycm_extra_conf.py file)
        let g:ycm_confirm_extra_conf = 0

        " - let clangd fully control code completion
        let g:ycm_clangd_uses_ycmd_caching = 0
        " - use installed clangd, not YCM-bundled clangd which doesn't get updates.
        let g:ycm_clangd_binary_path = exepath("clangd")


        let g:ycm_disable_signature_help = 0
        let g:ycm_auto_trigger = 1

        " - python completion settings
        " let g:ycm_python_interpreter_path = '/usr/bin/python'
        " let g:ycm_python_sys_path = []
        " let g:ycm_extra_conf_vim_data = [
          " \  'g:ycm_python_interpreter_path',
          " \  'g:ycm_python_sys_path'
          " \]
        let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
    endif " end if g:vim_plug_installed

" ***********************************************************************
" 7.2_Coc.nvim settings
" ***********************************************************************

if g:vim_plug_installed
    " To use coc.nvim:
    " sudo apt intall nodejs
    " sudo apt install npm
    " npm install -g yarn
    "
    " To open configuration file:
    " :CocConfig
    " To install clangd
    " :CocCommand clangd.install
    " To use it with python:
    " pip install jedi pylint neovim
    "
    " - coc plugins list
    " coc-omni is for vimspector's console completion
    let g:coc_global_extensions = [
    \ 'coc-ultisnips',
    \ 'coc-json',
    \ 'coc-css',
    \ 'coc-jedi',
    \ 'coc-highlight',
    \ 'coc-pairs',
    \ 'coc-cmake',
    \ 'coc-clangd',
    \ 'coc-omni'
    \ ]
    let g:coc_source_omni_filetypes=["VimspectorPrompt"]

    " - add coc status to statusline below
    if !exists('g:vimrc_has_been_sourced')
        set statusline^=%{coc#status()}
    endif

    " - map <ta>/<s-tab> to go to next/prev snippet for coc.nvim
    let g:coc_snippet_next = '<TAB>'
    let g:coc_snippet_prev = '<S-TAB>'

    " - disable auto pair of < for c,cpp files for coc.nvim
    autocmd FileType c,cpp let b:coc_pairs_disabled = ['<']
    autocmd FileType VimspectorPrompt let b:coc_pairs_disabled = ["(", "[", "{", "<", "'", "\"", "`"]

    " following is replacement for coc-settings.json
    if !empty($DISPLAY)  " if not on server
        " - coc language server settings for kotlin
        call coc#config('languageserver', {
            \ "kotlin": {
            \ "command": "kotlin-language-server",
            \ "filetypes": ["kotlin"]
            \ }
            \})
        " - let VimspectorPrompt buffer use omni completion
        call coc#config('coc.source.omni.filetypes',["VimspectorPrompt"])
    endif

    " User configuration object, define this variable when
    " you can't use coc#config()
    " - coc user settings 
    let g:coc_user_config={
        \ "diagnostic.errorSign": '✗',
        \ "diagnostic.warningSign": '⚠',
        \ "diagnostic.infoSign": '⚐',
        \ "diagnostic.hintSign": '🔔',
        \ "diagnostic.signOffset": 9999,
        \ "coc.preferences.enableFloatHighlight": v:false,
        \}

    if !empty($DISPLAY)  " if not on server
        " - highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')
    endif

    " - scroll popup window with <c-d> and <c-u> in insert mode
    inoremap <silent><expr> <c-d> pumvisible() ? "\<down>\<down>\<down>\<down>\<down>\<down>\<down>\<down>" : "\<c-d>"
    inoremap <silent><expr> <c-u> pumvisible() ? "\<up>\<up>\<up>\<up>\<up>\<up>\<up>\<up>" : "\<c-u>"

    " - map <up> and <down> and <c-u> and <c-d> to scroll in coc.nvim floating windows such as documentation window
    " If nvim >= 0.4.0 or vim >= 8.1.0750
    if has('nvim-0.4.0') || has('patch-8.2.0750')
        nnoremap <silent><nowait><expr> <down> coc#float#has_scroll() ? coc#float#scroll(1) : "\<down>"
        nnoremap <silent><nowait><expr> <up> coc#float#has_scroll() ? coc#float#scroll(0) : "\<up>"
        " nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
        " nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    else
        " For vim to scroll floating window
        function Find_cursor_popup(...)
            let radius = get(a:000, 0, 2)
            let srow = screenrow()
            let scol = screencol()

            " it's necessary to test entire rect, as some popup might be quite small
            for r in range(srow - radius, srow + radius)
                for c in range(scol - radius, scol + radius)
                    let winid = popup_locate(r, c)
                    if winid != 0
                        return winid
                    endif
                endfor
            endfor

            return 0
        endfunction

        " For vim to scroll floating window
        function Scroll_cursor_popup(down)
            let winid = Find_cursor_popup()
            if winid == 0
                return 0
            endif

            let pp = popup_getpos(winid)
            call popup_setoptions( winid,
                        \ {'firstline' : pp.firstline + ( a:down ? 8 : -8 ) } )

            return 1
        endfunction

        " nnoremap <expr> <c-d> Scroll_cursor_popup(1) ? '<esc>' : '<c-d>'
        " nnoremap <expr> <c-u> Scroll_cursor_popup(0) ? '<esc>' : '<c-u>'
        nnoremap <expr> <down> Scroll_cursor_popup(1) ? '<esc>' : '<down>'
        nnoremap <expr> <up> Scroll_cursor_popup(0) ? '<esc>' : '<up>'
    endif

    " - map <tab> for trigger completion and navigate to the next complete item
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction
    inoremap <silent><expr> <Tab>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<Tab>" :
          \ coc#refresh()

    " - map tab and s-tab for trigger completion with characters ahead and navigate.
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " - map <c-n> to trigger completion.
    inoremap <silent><expr> <c-n> coc#refresh()

    function! Toggle_show_signature()
        if !exists('g:is_coc_show_signature')
            let g:is_coc_show_signature=1
        endif
        if g:is_coc_show_signature && coc#float#has_float()
            let g:is_coc_show_signature=0
            exec "normal!\<left>\<right>"
            " call coc#float#close_all()
        else
            call CocActionAsync('showSignatureHelp') 
            let g:is_coc_show_signature=1
        endif
    endfunction

    " - map <c-p> to toggle show signature help
    inoremap <silent> <c-p> <c-o>:call Toggle_show_signature()<CR>

    " Modified from coc#float#jump()
    function! Jump_to_float() abort
        if !has('nvim')
            return
        endif
        let g:winids =[]
        for i in range(1, winnr('$'))
            let id = win_getid(i)
            let config = nvim_win_get_config(id)
            if !empty(config) && !empty(config['relative']) && config['relative']=='win'
                call add(g:winids, id)
            endif
        endfor
        if !empty(g:winids)
            call win_gotoid(g:winids[0])
        endif
    endfunction

    " - map <c-j> to jump to the floating window in normal mode
    nnoremap <c-j> :call Jump_to_float()<CR>

    " use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    " - map to navigate diagnostic
    nmap <silent> <Space>ep <Plug>(coc-diagnostic-prev)
    nmap <silent> <Space>eN <Plug>(coc-diagnostic-prev)
    nmap <silent> <Space>en <Plug>(coc-diagnostic-next)
    " - map goTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    
    " - map K to show documentation in preview window.
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    " - map function and class text objects such as select inside function vif
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " - map to generate clangd compile_commands.json according to Cmakelists.txt
    nnoremap <Space>cg :cd %:h<CR>:silent! Gcd<CR>:call VimuxCdWorkingDirectory()<CR>:call Run_to_tmux_or_directly("generate_clangd_json")<CR>
    " - map to restart coc server
    nnoremap <Space>cr :CocRestart<CR>
    " apply codeAction to the selected region.
    " " Example: `<leader>aap` for current paragraph
    xmap <space>ca  <Plug>(coc-codeaction-selected)
    nmap <space>ca  <Plug>(coc-codeaction-selected)
    " - map to change python interpreter
    autocmd FileType python nnoremap <buffer> <space>ci :CocCommand python.setInterpreter<CR>
    " - map to run coc command
    nnoremap <space>cc :CocCommand<CR>
endif  " end if g:vim_plug_installed

    " - map to show structure with the help of coc
    nnoremap <Space>cs :CocList outline<CR>
    " - map to show coc lists
    nnoremap <Space>cl :CocList lists<CR>

" ***********************************************************************
" 7.3_Tmux settings
" ***********************************************************************


" ***********************************************************************
" 7.3.1_Vimux settings
" ***********************************************************************

    " - function to run to another window if in tmux mode. Else run directly
    fun! Run_to_tmux_or_directly(command_str)
        if exists('$TMUX')
            call VimuxRunCommand(a:command_str)
            call feedkeys("<CR>")
        else
            exec "!" . a:command_str
        endif
    endf

    " when origin filetype==""
    " - set VimuxReplDefaultFiletype for repl
    let g:VimuxReplDefaultFiletype='python'
    let g:VimuxOrientation = "h"
    let g:VimuxHeight = "50"

    " - map to call some tmux command
    nmap <space>: :call VimuxPromptCommand()<CR><c-f>:exec "set filetype=" . g:previous_buf_filetype<CR>i
    nmap <space>v: :call VimuxPromptCommand()<CR>
    nmap <space>vo :call VimuxOpenRunner()<CR>
    nmap <space>vl :call VimuxRunLastCommand()<CR>
    nmap <space>vc :call VimuxCloseRunner()<CR>
    nmap <space>vr :call VimuxRunCommand("!!\n")<CR>

    " - function to run visual region in another tmux pane
    function! VimuxSlimeVisual()
        " delete empty line (mainly for python)
        let s:vimux_slime_delete_blank_line=substitute(@v,'\n\n\+','\n','g')
        if(&filetype=='python')
            " add empty line to jump out of block (for python, ipython does
            " not need the following line)
            let s:vimux_slime_delete_blank_line=substitute(s:vimux_slime_delete_blank_line,'\(\n\s[^\n]\+\n\)\(\S\)','\1\n\2','g')
            " don't jump for else: and elif: (for python)
            let s:vimux_slime_delete_blank_line=substitute(s:vimux_slime_delete_blank_line,'\n\nelse:','\nelse:','g')
            let s:vimux_slime_delete_blank_line=substitute(s:vimux_slime_delete_blank_line,'\n\(\nelif\W\)','\1','g')
        endif

        call VimuxRunCommand(s:vimux_slime_delete_blank_line)
    endfunction

    " - function to show python doc of register v
    function! VimuxShowPythonDocVisual()
        let s:to_search_object= "print(" . @v . ".__doc__)"
        call VimuxRunCommand(s:to_search_object)
    endfunction


    " - function to run current line in another tmux pane
    function! VimuxSlimeNormal()
        call VimuxRunCommand(getline("."))
    endfunction

    " - map to run visual region in another tmux pane
    vmap <space>vs "vy :call VimuxSlimeVisual()<CR>
    nmap <space>vs :call VimuxSlimeNormal()<CR>

    " - toggle using vim for repl in another pane
    function! VimuxForRepl()
        if !exists("b:VimuxForReplFlag")
            let b:VimuxForReplFlag=0
        endif

        if b:VimuxForReplFlag
            iunmap <buffer> <enter>
            vunmap <buffer> <enter>
            nunmap <buffer> <enter>
            if(&filetype=='python')
                vunmap <buffer> K
            endif
            let b:VimuxForReplFlag=0
            echo "REPL mode off."
        else
            inoremap <buffer> <enter> <c-o>$<c-o>:call VimuxSlimeNormal()<CR><enter>
            vnoremap <buffer> <enter> "vy :call VimuxSlimeVisual()<CR>
            nnoremap <buffer> <enter> :call VimuxSlimeNormal()<CR>j
            " VimuxRunCommand("cd " . expand("%:p:h"))
            if(!(&filetype=='matlab' && executable('matlab')))
                call VimuxCdWorkingDirectory()
            endif

            let b:VimuxForReplFlag=1

            if(&filetype=='')
                exec "set filetype=" . g:VimuxReplDefaultFiletype
            endif

            " set initial code for specific filetype
            if(&filetype=='python')
                vnoremap <buffer> K     "vy :call VimuxShowPythonDocVisual()<CR>
                VimuxRunCommand("python")
                echo "python repl mode is on."
            endif
            if(&filetype=='javascript')
                VimuxRunCommand("node")
                echo "javascript repl mode is on."
            endif
            if(&filetype=='matlab')
                if(executable('matlab'))  " run matlab
                    echo "Matlab repl mode is on."
                else  " run octave
                    VimuxRunCommand("octave --no-window-system")
                endif
            endif
            if(&filetype=='julia')
                VimuxRunCommand("julia")
            endif

            " if(&filetype=='vim') see function VimEnterExec
        endif
    endfunction
    " enter repl for vim buffer
    function! VimEnterExec()
        if !exists("b:VimEterExecFlag")
            let b:VimEterExecFlag=0
        endif

        if b:VimEterExecFlag
            iunmap <buffer> <enter>
            vunmap <buffer> <enter>
            nunmap <buffer> <enter>
            let b:VimEterExecFlag=0
            echo "vim repl mode is off."
        else
            inoremap <buffer> <enter> <c-o>$<c-o>:exec getline(".")<CR><CR>
            vnoremap <buffer> <enter> "vy :@v<CR>
            nnoremap <buffer> <enter> :exec getline(".")<CR>j

            let b:VimEterExecFlag=1
            echo "vim repl mode is on."
        endif
    endfunction


    " - map to toggle using vim for repl in another pane
    nmap <space>vp :call VimuxForRepl()<CR>
    autocmd FileType vim nnoremap <buffer> <space>vp :call VimEnterExec()<CR>

    " - function to change another pane's directory for tmux
    function!VimuxCdWorkingDirectory()
        call VimuxRunCommand(" cd ".expand('%:p:h'))
        call VimuxRunCommand(" cd `git rev-parse --show-toplevel 2>/dev/null || echo .`")
    endfunction

" ***********************************************************************
" 7.3.2_Vim-tmux-navigator settings
" ***********************************************************************

    " - Disable default vim-tmux-navigator mappings
    let g:tmux_navigator_no_mappings = 1

    " - map to navigate for both tmux and vim
    nnoremap <silent> <A-h> :call CloseMaximize()<CR>:TmuxNavigateLeft<CR>
    nnoremap <silent> <A-j> :call CloseMaximize()<CR>:TmuxNavigateDown<CR>
    nnoremap <silent> <A-k> :call CloseMaximize()<CR>:TmuxNavigateUp<CR>
    nnoremap <silent> <A-l> :call CloseMaximize()<CR>:TmuxNavigateRight<CR>
    nnoremap <silent> <A-o> :call CloseMaximize()<CR>:TmuxNavigatePrevious<CR>

    " - function to maximize considering all vim panes and tmux panes
    function! ToggleMaximizeTmux()
        if !s:CheckWarnVimPlugInstalled()
            return
        endif
        if g:isToggledVertically || g:isToggledHorizontally
            silent! call ToggleMaximize()
            silent! !tmux resize-pane -Z
        else
            silent! !tmux resize-pane -Z 
            redraw
            sleep 100m
            silent! call ToggleMaximize()
        endif

    endfunction

    " - function to close maximize
    function!CloseMaximize()
        if !g:vim_plug_installed
            return
        endif
        if g:isToggledVertically || g:isToggledHorizontally
            silent! call ToggleMaximize()
        endif

    endfunction

    " - map to toggle maximize tmux
    nnoremap <silent> <A-z> :call ToggleMaximizeTmux()<CR>
    inoremap <silent> <A-z> <c-o>:call ToggleMaximizeTmux()<CR>

" ***********************************************************************
" 7.4_Vimspector
" ***********************************************************************

    " - run following to install
    " :VimspectorInstall
    " Use CodeLLDB instead of vscode-cpptools in macOS
    " Use <Space>dg to generate .vimspector.json file for further config in
    " project directory.
    "
    " variables replacement for .vimspector.json:
    " https://puremourning.github.io/vimspector/configuration.html#predefined-variables

    " - vimspector gadgets (debugger program)
    let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]

    " - map <tab> for auto completion in Vimspector console (<c-x><c-o> is omni commpletion)
    autocmd FileType VimspectorPrompt inoremap <buffer> <silent><expr> <Tab>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<Tab>" :
          \ "\<c-x>\<c-o>"

    " - map for debug mode of vimspector
    nnoremap <Space>dd :GitGutterDisable<CR>:call vimspector#Continue()<CR>
    nnoremap <Space>dc :GitGutterDisable<CR>:call vimspector#Continue()<CR> 
    nnoremap ,cd :GitGutterDisable<CR>:call vimspector#Continue()<CR> 
    nnoremap <Space>dp :call vimspector#Pause()<CR>
    nnoremap <Space>dr :call vimspector#Restart()<CR>
    nnoremap <Space>de :call vimspector#Stop()<CR>
    nnoremap <Space>dq :GitGutterEnable<CR>:call vimspector#Reset()<CR>
    nnoremap <Space>db :call vimspector#ToggleBreakpoint()<CR>
    nnoremap <Space>dB <c-u>call vimspector#ToggleBreakpoint(
                \ { 'condition': input( 'Enter condition expression: ' ),
                \   'hitCondition': '0' }
                \ )<CR>
    nnoremap <Space>dfb :call vimspector#AddFunctionBreakpoint()<CR>
    nnoremap <Space>ds :call vimspector#StepInto()<CR>
    nnoremap <Space>dn :call vimspector#StepOver()<CR>
    nnoremap <Space>do :call vimspector#StepOut()<CR>
    nnoremap <Space>dt :call vimspector#RunToCursor()<CR>
    nnoremap <Space>d: :VimspectorEval 
    nnoremap gc :GitGutterDisable<CR>:call vimspector#Continue()<CR> 
    nnoremap gp :call vimspector#Pause()<CR>
    nnoremap ge :call vimspector#Stop()<CR>
    nnoremap gq :GitGutterEnable<CR>:call vimspector#Reset()<CR>
    nnoremap gb :call vimspector#ToggleBreakpoint()<CR>
    nnoremap <silent> gB :<c-u>call vimspector#ToggleBreakpoint(
                \ { 'condition': input( 'Enter condition expression: ' ),
                \   'hitCondition': '0' }
                \ )<CR>
    nnoremap gs :call vimspector#StepInto()<CR>
    nnoremap gn :call vimspector#StepOver()<CR>
    nnoremap go :call vimspector#StepOut()<CR>
    nnoremap gt :call vimspector#RunToCursor()<CR>
    nnoremap g: :VimspectorEval 

    " - map to copy .vimspector.json file to current directory for further config in project directory.
    nnoremap <Space>dg :cd %:h<CR>:silent! Gcd<CR>:!cp ~/Software/vim/vimspector/.vimspector.json .<CR>:e .vimspector.json<CR>

" ***********************************************************************
" 7.5_Vim-gdb
" ***********************************************************************

    if has('nvim')
        nnoremap ,qq :GdbSaveBreakpoints<CR>:sleep 1<CR>:GdbDebugStop<CR>
        if exists(':tnoremap')
            tnoremap <c-b> save breakpoints .gdb_breakpoints<CR>q<CR>
        endif
    else
        nnoremap ,qq :call TermDebugSendCommand('save breakpoints .gdb_breakpoints')<CR>:call TermDebugSendCommand('q')<CR>
        if exists(':tnoremap')
            tnoremap <c-b> save breakpoints .gdb_breakpoints<CR>q<CR>
        endif
    endif

" ***********************************************************************
" 7.6_Format
" ***********************************************************************


" ***********************************************************************
" 7.6.1_Vim-autoformat
" ***********************************************************************

    " Need clang-format which can be installed by sudo apt install clang-format

    let g:autoformat_autoindent = 0
    let g:autoformat_retab = 0
    let g:autoformat_remove_trailing_spaces = 0

    let g:formatdef_clangformat ="'clang-format -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" -style=\"{ AlignTrailingComments: true, '.(&textwidth ? 'ColumnLimit: '.&textwidth.', ' : '').(&expandtab ? 'UseTab: Never, IndentWidth: '.shiftwidth() : 'UseTab: Always').'}\"'"
    " map ,f to format file
    nnoremap ,f :Autoformat<CR>
    xnoremap ,f :Autoformat<CR>

" ***********************************************************************
" 7.6.2_Neoformat
" ***********************************************************************

    " nnoremap ,f :Neoformat<CR>
    " xnoremap ,f :Neoformat<CR>

    " following command contains bug: after command, ,cc will be mapped to cpp
    " run command

" ***********************************************************************
" 7.7_Ale
" ***********************************************************************

    " let g:ale_sign_error = '✗'
    " let g:ale_sign_warning = '⚠'
    " " suppress the display of errors when you move the cursor onto their line (prevent cursor from disappearing)
    " let g:ale_echo_cursor = 0


    " Following 3 commands are replaced by coc.nvim
    " nmap <silent> <Space>ep <Plug>(ale_previous_wrap)
    " nmap <silent> <Space>eN <Plug>(ale_previous_wrap)
    " nmap <silent> <Space>en <Plug>(ale_next_wrap)

    " Available Linters: 'flake8', 'mypy', 'prospector', 'pycodestyle', 'pyflakes', 'pylint', 'pyls', 'pyre', 'vulture'
    let g:ale_linters = {
    \   'python': ['flake8','pylint'],
    \   'c':[],
    \   'cpp':[],
    \}

    let g:ale_fixer= {
    \   'python': ['autopep8'],
    \   'c':[],
    \   'cpp':[],
    \}

    " to suppress errors by flake8 globally,use OpenFlake8Config
    " add at the end of the error line `# noqa EXXX` XXX is num to suppress an
    " error there

" ***********************************************************************
" 7.8_Cscope
" ***********************************************************************

    " call cscope_build in project root dir first
    if has("cscope")

        " - use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
        set cscopetag

        " - check cscope for definition of a symbol before checking ctags: 
        " set to 1 if you want the reverse search order.
        set csto=0

        " - add any cscope database in current directory
        if filereadable("cscope.out")
            cs add cscope.out  
        " else add the database pointed to by environment variable 
        elseif $CSCOPE_DB != ""
            cs add $CSCOPE_DB
        endif

        " - show msg when any other cscope db added
        set cscopeverbose  

        "   's'   symbol: find all references to the token under cursor
        "   'g'   global: find global definition(s) of the token under cursor
        "   'c'   calls:  find all calls to the function name under cursor
        "   't'   text:   find all instances of the text under cursor
        "   'e'   egrep:  egrep search for the word under cursor
        "   'f'   file:   open the filename under cursor
        "   'i'   includes: find files that include the filename under cursor
        "   'd'   called: find functions that function under cursor calls

        " - mappings for cscope
        nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
        nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
        nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
        nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
        nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
        nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
        " nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
        nmap <C-\>i :cs find i <C-R>=expand("%:p:t")<CR>$<CR>
        nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	

        nmap <Space>ss :cs find s <C-R>=expand("<cword>")<CR><CR>	
        nmap <Space>sg :cs find g <C-R>=expand("<cword>")<CR><CR>	
        nmap <Space>sc :cs find c <C-R>=expand("<cword>")<CR><CR>	
        nmap <Space>st :cs find t <C-R>=expand("<cword>")<CR><CR>	
        nmap <Space>se :cs find e <C-R>=expand("<cword>")<CR><CR>	
        nmap <Space>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>	
        nmap <Space>si :cs find i <C-R>=expand("%:p:t")<CR>$<CR>
        nmap <Space>sd :cs find d <C-R>=expand("<cword>")<CR><CR>	
    endif


" ***********************************************************************
" 8_Language settings ***************************************************
" 8.1_Html/css
    " - Enable just for html/css
" 8.2_Julia
    " - set julia doc path
" 8.3_Freefem++
    " - freefem++ file type
    " - run freefem++
    " - load completion.edp for better completion
" 8.4_Python settings
    " - run current python buffer
    " - debug current python buffer
    " - set .ufl as python type file(fenics ufl file)
" 8.5_Matlab/octave settings
    " - function to show matlab help
    " - function to go to matlab definition
    " - map to run matlab/octave file
    " - map to go to matlab help/definition
    " - function to toggle breakpoints for matlab
    " - command to clear all breakpoints for matlab
    " - map to matlab debugging command
" 8.6_Javascript settings
    " - map to run current javascript buffer
" 8.7_C/C++ settings
    " - map to run current c/cpp project/file
    " - map to make current c/cpp project/file
    " - map to run c/cpp with mpi
    " - debug current c/cpp project
    " - map M-; to end sentence for c/c++ file type
" 8.8_Shell settings
    " - map to debug current bash buffer
" 8.9_Latex settings
" 8.9.1_Basic settings
    " - map to create/goto abbreviation
    " - latex mode jump to bibtex
    " - auto load abbreviation at latex startup
" 8.9.2_Vimtex settings
    " - set latex pdf viewer
    " - enable latex folding
    " - vimtex quickfix mode
    " - disable default vimtex mappings
    " - some latex mode specified mappings
    " - start vim server for latex preview at startup
    " - enable auto save for real-time preview
" ***********************************************************************


" ***********************************************************************
" 8.1_Html/css
" ***********************************************************************

" emmet-vim {{{ 
    " - Enable just for html/css
    let g:user_emmet_install_global = 0
    autocmd FileType html,css EmmetInstall
" }}}


" ***********************************************************************
" 8.2_Julia
" ***********************************************************************

    " - set julia doc path
    let g:julia#doc#juliapath=$HOME.'/Software/julia/julia-1.3.1/bin/julia'

" ***********************************************************************
" 8.3_Freefem++
" ***********************************************************************

    " - freefem++ file type
    au BufNewFile,BufRead *.edp setf edp
    au BufNewFile,BufRead *.idp setf edp

    " - run freefem++
    au FileType  edp nnoremap ,cc :w<CR>:call Run_to_tmux_or_directly("cd ".expand('%:p:h')." && FreeFem++ ".expand('%:p'))<CR>

    " - load completion.edp for better completion
    au FileType  edp call s:LoadFreefemCompletion()
    let g:freefemCompletionNotLoaded=1
    function!s:LoadFreefemCompletion()
        if g:freefemCompletionNotLoaded
            let g:freefemCompletionNotLoaded=0
            view $HOME/Software/freefem++/freefem_include/completion.edp
            set filetype=edp
            echo "Completion.edp is loaded for completion of custom header functions"
            b#
        endif
    endfunction

" ***********************************************************************
" 8.4_Python settings
" ***********************************************************************
    " - run current python buffer
    autocmd FileType python nnoremap <buffer> ,cc :w<CR>:call Run_to_tmux_or_directly("python3 " . expand("%:p"))<CR>
    " - debug current python buffer
    autocmd FileType python nnoremap <buffer> ,cd :w<CR>:cd %:h<CR>:GdbStartPDB python -m pdb <c-r>%<CR>
    " - set .ufl as python type file(fenics ufl file)
    au BufNewFile,BufRead *.ufl setf python


" ***********************************************************************
" 8.5_Matlab/octave settings
" ***********************************************************************

    " filetype specific keymap
    " to see more filetype, run command :
    " echo join(map(split(globpath(&rtp, 'ftplugin/*.vim'), '\n'), 'fnamemodify(v:val, ":t:r")'), "\n")

    " - function to show matlab help
    fun! MatlabHelp()
        let l:word_under_cursor = expand("<cword>")
        if executable('matlab')
            call Run_to_tmux_or_directly('help ' . l:word_under_cursor)
        else
        " --- Show octave help --------------------------------------------------
            e /tmp/odd_for_vim_matlab.md
            1,$d
            exec "read !octave <(echo 'help " . l:word_under_cursor . "')"
            exec "normal! ggd/----------------------------\<cr>"
            write
        endif
    endfunction
    " - function to go to matlab definition
    fun! MatlabGoToDefinition()
        let l:word_under_cursor = expand("<cword>")
        if bufname('/' . l:word_under_cursor . '.m')!=''
            exec 'b ' . bufname('/' . l:word_under_cursor . '.m')
            return
        endif
        if executable('matlab')
        " --- Open definition with matlab ---------------------------------------
            let l:odd_clipboard=@+
            call Run_to_tmux_or_directly('open ' . l:word_under_cursor)
            call Run_to_tmux_or_directly(' yy')
            sleep 800m
            call Run_to_tmux_or_directly(' qq')

            if filereadable(@+)
                exec "e " . expand(@+)
                " exec "echo " . expand(@+)
            else
                echo 'Fail to open matlab definition file.'
            endif
            let @+=l:odd_clipboard
        elseif l:ifem_file_path != ''
        " --- Show ifem definition ----------------------------------------------
            let l:ifem_file_path=system('ag -l "^function .+\W' . expand('<cword>') . '\W" $HOME/Software/ifem/ifem/')
            exec "view " . l:ifem_file_path
        else
        " --- Show octave help --------------------------------------------------
            e /tmp/odd_for_vim_matlab.md
            1,$d
            exec "read !octave <(echo 'help " . l:word_under_cursor . "')"
            exec "normal! ggd/----------------------------\<cr>"
            write
        endif
    endf

    " - map to run matlab/octave file
    autocmd FileType matlab nnoremap <buffer> ,cc :w<CR>:!octave %<CR>
    autocmd FileType matlab nnoremap <buffer> ,cc :w<CR>:call Run_to_tmux_or_directly("octave " . expand("%:p"))<CR>
    if executable('matlab')
        autocmd FileType matlab nnoremap <buffer> ,cc :w<CR>:call Run_to_tmux_or_directly("run('" . expand("%:p") . "')")<CR>
    endif

    " - map to go to matlab help/definition
    autocmd FileType matlab nnoremap <buffer> K :call MatlabHelp()<CR>
    autocmd FileType matlab nnoremap <buffer> gd :call MatlabGoToDefinition()<CR>

    if executable('matlab')
        " How many counts :ClearAllBreakpoints is called
        if !exists("g:matlab_clear_counts")
            let g:matlab_clear_counts=0
        endif

        " - function to toggle breakpoints for matlab
        fun! Toggle_breakpoints_for_matlab()
            if !exists("b:matlab_breakpoints_lists")
                let b:matlab_breakpoints_lists=[]
            endif
            if !exists("b:matlab_buffer_clear_count")
                let b:matlab_buffer_clear_count=g:matlab_clear_counts
            endif
            if b:matlab_buffer_clear_count < g:matlab_clear_counts
                let b:matlab_buffer_clear_count=g:matlab_clear_counts
                let b:matlab_breakpoints_lists=[]
            endif
            if index(b:matlab_breakpoints_lists,line(".")) >= 0
                call Run_to_tmux_or_directly("dbclear '" . expand("%:p") . "' at " . line("."))
                call remove(b:matlab_breakpoints_lists,index(b:matlab_breakpoints_lists,line(".")))
                echo 'breakpoint cleared'
            else
                call Run_to_tmux_or_directly("dbstop '" . expand("%:p") . "' at " . line("."))
                call add(b:matlab_breakpoints_lists,line("."))
                echo 'breakpoint added'
            endif
        endfunction
        " - command to clear all breakpoints for matlab
        fun! Clear_all_breakpoints_for_matlab()
                call Run_to_tmux_or_directly("dbclear all")
                let g:matlab_clear_counts=g:matlab_clear_counts+1
        endfunction
        " matlab debug: :ClearAll  - clear all breakpoints
        com!ClearAllBreakpoints call Clear_all_breakpoints_for_matlab()

        " - map to matlab debugging command
        " matlab debug: gb  - toggle breakpoint
        autocmd FileType matlab nnoremap <buffer> gb :call Toggle_breakpoints_for_matlab()<CR>
        " matlab debug: glb - list breakpoints
        autocmd FileType matlab nnoremap <buffer> glb :call Run_to_tmux_or_directly('dbstatus')<CR>
        " matlab debug: gc  - continue
        autocmd FileType matlab nnoremap <buffer> gc :call Run_to_tmux_or_directly('dbcont')<CR>
        " matlab debug: gn  - step next
        autocmd FileType matlab nnoremap <buffer> gn :call Run_to_tmux_or_directly('dbstep')<CR>
        " matlab debug: gs  - step in
        autocmd FileType matlab nnoremap <buffer> gs :call Run_to_tmux_or_directly('dbstep in')<CR>
        " matlab debug: go  - step out
        autocmd FileType matlab nnoremap <buffer> go :call Run_to_tmux_or_directly('dbstep out')<CR>
        " matlab debug: gq  - quit debug
        autocmd FileType matlab nnoremap <buffer> gq :call Run_to_tmux_or_directly('dbquit')<CR>
        " matlab debug: gls - show current line
        autocmd FileType matlab nnoremap <buffer> gls :call Run_to_tmux_or_directly('dbstack')<CR>
        " matlab debug: gku  - up one stack
        autocmd FileType matlab nnoremap <buffer> gku :call Run_to_tmux_or_directly('dbup')<CR>
        " matlab debug: gkd  - down one stack
        autocmd FileType matlab nnoremap <buffer> gkd :call Run_to_tmux_or_directly('dbdown')<CR>
        " matlab debug: g?  - show help
        autocmd FileType matlab nnoremap <buffer> g? :!cat ~/Software/vim/vimrc <bar>grep 'matlab debug:'<CR>
        if $TMUX != ''
            autocmd BufWritePost *.m call Run_to_tmux_or_directly('clear ' . expand('%:p'))
        endif
    endif

" ***********************************************************************
" 8.6_Javascript settings
" - map to run current javascript buffer
" ***********************************************************************

    " - map to run current javascript buffer
    autocmd FileType javascript nnoremap <buffer> ,cc :w<CR>:call Run_to_tmux_or_directly("node " . expand("%:p"))<CR>

" ***********************************************************************
" 8.7_C/C++ settings
" ***********************************************************************

    " - map to run current c/cpp project/file
    autocmd FileType c,cpp nnoremap <buffer> ,cc :w<CR>:cd %:h<CR>:silent! Gcd<CR>:call VimuxCdWorkingDirectory()<CR>:call Run_to_tmux_or_directly("cmake_run ".expand('%:p')." --less-output")<CR>
    autocmd BufRead,BufNewFile  CMakeLists.txt nnoremap <buffer> ,cc :w<CR>:cd %:h<CR>:silent! Gcd<CR>:call VimuxCdWorkingDirectory()<CR>:call Run_to_tmux_or_directly("cmake_run ".expand('%:t')." --less-output")<CR>
    " - map to make current c/cpp project/file
    autocmd FileType c,cpp nnoremap <buffer> ,cm :w<CR>:cd %:h<CR>:silent! Gcd<CR>:call VimuxCdWorkingDirectory()<CR>:call Run_to_tmux_or_directly("cmake_run ".expand('%:p')." --make-only")<CR>
    autocmd BufRead,BufNewFile  CMakeLists.txt nnoremap <buffer> ,cm :w<CR>:cd %:h<CR>:silent! Gcd<CR>:call VimuxCdWorkingDirectory()<CR>:call Run_to_tmux_or_directly("cmake_run ".expand('%:t')." --make-only")<CR>

    " - map to run c/cpp with mpi
    let g:mpi_processors_num=4
    com! -nargs=1 SetMpiProcessors let g:mpi_processors_num=<args>
    autocmd FileType c,cpp nnoremap <buffer> ,cp :w<CR>:cd %:h<CR>:silent! Gcd<CR>:call VimuxCdWorkingDirectory()<CR>:call Run_to_tmux_or_directly("cmake_run ".expand('%:p')." --less-output --make-only && mpirun -n ".g:mpi_processors_num." `make_find_executable`")<CR>
    autocmd BufRead,BufNewFile  CMakeLists.txt nnoremap <buffer> ,cp :w<CR>:cd %:h<CR>:silent! Gcd<CR>:call VimuxCdWorkingDirectory()<CR>:call Run_to_tmux_or_directly("cmake_run ".expand('%:p')." --less-output --make-only && mpirun -n ".g:mpi_processors_num." `make_find_executable`")<CR>

    if has('nvim')
        " - debug current c/cpp project
        autocmd FileType c,cpp nnoremap <buffer> ,cd :w<CR>:cd %:h<CR>:silent! Gcd<CR>:GdbStart gdb -q -command="$HOME/Software/vim/gdb_init" `make_find_executable` <CR>
        autocmd BufRead,BufNewFile  CMakeLists.txt nnoremap <buffer> ,cd :w<CR>:cd %:h<CR>:silent! Gcd<CR>:GdbStart gdb -q -command="$HOME/Software/vim/gdb_init" `make_find_executable` <CR>
    else
        autocmd FileType c,cpp nnoremap <buffer> ,cd :set mouse=a<CR>:w<CR>:cd %:h<CR>:silent! Gcd<CR>:exec "Termdebug " . system('make_find_executable')<CR><c-w>j<c-w>j<c-w>L:sleep 1<CR><c-w>hstart<CR>source .gdb_breakpoints<CR>
        " autocmd FileType c,cpp nnoremap <buffer> ,cd :set mouse=a<CR>:w<CR>:cd %:h<CR>:silent! Gcd<CR>:exec "Termdebug -command=~/Software/vim/gdb_init " . system('make_find_executable')<CR><c-w>j<c-w>j<c-w>L:sleep 1<CR><c-w>h
    endif


    " - map M-; to end sentence for c/c++ file type
    autocmd FileType c,cpp imap <buffer> <a-;> <c-e>;<CR>

" ***********************************************************************
" 8.8_Shell settings
" ***********************************************************************

if has('nvim')
    " - map to debug current bash buffer
    autocmd FileType sh nnoremap <buffer> ,cd :w<CR>:cd %:h<CR>:GdbStartBashDB bashdb <c-r>%<CR>
endif

" ***********************************************************************
" 8.9_Latex settings
" ***********************************************************************


" ***********************************************************************
" 8.9.1_Basic settings
" ***********************************************************************

    " - map to create/goto abbreviation
    autocmd FileType tex vnoremap <buffer> <m-s> "vy:call VisualSetAbbreviation()<CR>
    autocmd FileType tex nnoremap <buffer> <m-s> :call ShowAbbreviations()<CR>
    autocmd FileType tex inoremap <buffer> <m-s> <c-o>:call ShowAbbreviations()<CR>
    autocmd BufRead,BufNewFile */abbrev_defs.vim nnoremap <buffer> <m-s> :b#<CR>
    autocmd BufRead,BufNewFile */abbrev_defs.vim inoremap <buffer> <m-s> <c-o>:b#<CR>

    " - latex mode jump to bibtex
    autocmd FileType tex nnoremap <buffer> <m-r> :e $HOME/Software/latex/bibtex/bib/ref.bib<CR>
    autocmd BufRead,BufNewFile $HOME/Software/latex/bibtex/bib/ref.bib nnoremap <buffer> <m-r> :b#<CR>

    " - auto load abbreviation at latex startup
    autocmd FileType tex LoadAbbreviations

" ***********************************************************************
" 8.9.2_Vimtex settings
" ***********************************************************************

    let g:tex_flavor='latex'  " for compatibility with vim version >= 8.2
    " - set latex pdf viewer
    let g:vimtex_view_general_viewer = 'zathura'
    let g:vimtex_view_method='zathura'
    " - enable latex folding
    " let g:vimtex_fold_enabled=1
    " - vimtex quickfix mode
    let g:vimtex_quickfix_open_on_warning=0
    let g:vimtex_quickfix_mode=0

    " - disable default vimtex mappings
    let g:vimtex_mappings_enabled = 0

    let g:vimtex_compiler_latexmk_engines = {
        \ '_'                : '-pdf',
        \ 'pdflatex'         : '-pdf',
        \ 'dvipdfex'         : '-pdfdvi',
        \ 'lualatex'         : '-lualatex',
        \ 'xelatex'          : '-xelatex',
        \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
        \ 'context (luatex)' : '-pdf -pdflatex=context',
        \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
        \}

    " - neovim compatibility for vimtex
    " pip3 install --user pynvim neovim-remote
    " if `python3 -c 'import pynvim` returns without error and `nvr` starts
    " neovim from the command line, everything should be good to go
    if has('nvim')
    endif

    " - some latex mode specified mappings
    function! DefLatexMappings()
        nmap <buffer> ,i <plug>(vimtex-info)
        nmap <buffer> ,b <plug>(vimtex-compile)
        nmap <buffer> ,c <plug>(vimtex-clean)
        nmap <buffer> ,v <plug>(vimtex-view)
        inoremap <buffer> <m-v> <c-o>:VimtexView<CR>
        nmap <buffer> ,r <plug>(vimtex-reverse-search)
        nmap <buffer> ,e <plug>(vimtex-errors)
        inoremap <buffer> <c-d> _{}<left>
        inoremap <buffer> <c-u> ^{}<left>
        inoremap <buffer> <c-o> $$<left>
        inoremap <buffer> <c-b> \textbf{}<left>
        nnoremap <buffer> ? :echo "Keymap: (1) ,b : compile  (2) ,v : view\n        (3) ,e : show errors  (4) ,c : clean\n        (5) M-s : create/goto abbreviation  (6) M-r : show bib file"<CR>
        nnoremap <buffer> z? ?
    endfunction
    autocmd FileType tex call DefLatexMappings()

    " - start vim server for latex preview at startup
    " - run :echo serverlist() to ensure a server was successfully started
    function!StartLatexServer()
        if empty(v:servername) && exists('*remote_startserver')
          call remote_startserver('VIM')
        endif
    endfunction
    autocmd FileType tex call StartLatexServer()

    " - enable auto save for real-time preview
    " autocmd FileType tex autocmd TextChangedI <buffer> call LatexAutoSave(5)
    " autocmd FileType tex autocmd CursorHoldI,CursorHold <buffer> silent update
    " autocmd FileType tex autocmd TextChanged <buffer> call LatexAutoSave(0)
    let g:latex_auto_save_count=0
    function!LatexAutoSave(save_count)
        if g:latex_auto_save_count >= a:save_count
            let g:latex_auto_save_count=0
            silent write
        else
            let g:latex_auto_save_count=g:latex_auto_save_count + 1
        endif
    endfunction

" ***********************************************************************
" 9_Utilities ***********************************************************
" 9.1_Translation
    " - set translation repl base directory
    " - translation auto repl
    " - s: function to translate repl file
    " - function to add count to translate for repl
    " - map SPC hr to start repl translation
    " - function to translate region
    " - map SPC hc to translate
" 9.2_Vim-multiple-cursor
    " - enable mouse for vim-multiple-cursor
    " - clear default mappings of vim-multiple-cursor
    " - map of mouse for vim-multiple-cursor
    " - map g/ to start regex search for vim-multiple-cursor
    " - map M-j/M-k to add cursor down/up for vim-multiple-cursor
    " - map 1 to add increasing numbers for vim-multiple-cursor
    " - map M-a to select all occurence in normal mode for vim-multiple-cursor
    " - Select all that match visual selection (it is a visual map)
    " - map z< to align char for vim-multiple-cursor
" 9.3_Tagbar & NERDTree
    " - map SPC 0 to toggle nerdtree
    " - map SPC fp to find current file in nerdtree
    " - map SPC <enter>/M-m to toggle tagbar
    " - order tags by order in the file instead of by name. Press s to toggle.
" 9.4_Git
    " - map SPC gs to show git status
    " - map SPC gd to show git difference
    " - map SPC gc to commit for git
    " - map SPC gfm/SPC gfr to move/remove for git
    " - map SPC gl to show git history
    " - map to show next/previous history in git history mode
    " - some other mappings for git
    " - move to the same line when swithing in git history mode
" 9.5_Fuzzy search
" 9.5.1_Fzf
    " - this is the default extra key bindings for fzf
    " - layout for fzf
    " - in Neovim, you can set up fzf window using a Vim command
    " - customize fzf colors to match your color scheme
    " - enable per-command history for fzf
    " - command to search help (FindActions) with fzf
    " - command to preview and open project file with fzf
    " - function to show changes of current files with fzf
    " - command to show changes of current files with fzf
    " - function to show jumps location with fzf
    " - command to show jumps location with fzf
    " - command to show most recent file with fzf
    " - s: function to get buffers name list
    " - function to show buffers with fzf
    " - command to show buffers with fzf
    " - map SPC hk to search keymap definition
    " - map for insert mode completion with fzf
" 9.5.2_Ctrlp
    " - ctrlp extensions
    " - map C-p to ctrlp
    " - set current working directory for ctrlp
    " - let ctrlp search hidden files
" 9.6_Easymotion
    " - set prefix for easymotion
    " - mappings for easymotion
" 9.7_TCommentO
" 9.8_Scratch
" 9.9_snippets
    " - snippets of vim-snippets are in folders under:
    " - custom snippets are in folders under:
    " - map to trigger configuration
    " - map to jump forward/backward in snips
    " - split your window when :UltiSnipsEdit 
    " - snip style for python
    " - snip meta data
" 9.10_Vim-expand-region
" 9.11_Ranger
" 9.12_Abbreviation
    " - function to set visual region to new abbreviation
    " - map SPC va to set visual region to new abbreviation
    " - function to save abbreviation (to file ./abbrev_defs.vim)
    " - function to load abbreviation (from file ./abbrev_defs.vim)
    " - function to show abbreviation (go to file ./abbrev_defs.vim)
    " - map C-c C-c to reload abbreviation when in ./abbrev_defs.vim
" 9.13_Undotree
" ***********************************************************************


" ***********************************************************************
" 9.1_Translation
" ***********************************************************************

    " - set translation repl base directory
    let g:translation_dir=system('translate -d')
    let g:toBeTranslate_file=g:translation_dir . '/toBeTranslate.txt'

    " - translation auto repl
    " execute 'autocmd BufRead,BufNewFile ' . g:toBeTranslate_file . ' autocmd TextChangedI <buffer> call TranslateCount(5)'
    execute 'autocmd BufRead,BufNewFile ' . g:toBeTranslate_file . ' autocmd TextChanged <buffer> call TranslateCount(0)'
    execute 'autocmd BufRead,BufNewFile ' . g:toBeTranslate_file . ' autocmd CursorHoldI,CursorHold <buffer> call TranslateCount(0)'
    execute 'autocmd BufRead,BufNewFile ' . g:toBeTranslate_file . ' map <buffer> <c-s> :call TranslateCount(0)<CR>'
    execute 'autocmd BufRead,BufNewFile ' . g:toBeTranslate_file . ' inoremap <buffer> <c-s> <c-o>:call TranslateCount(0)<CR>'
    execute 'autocmd BufRead,BufNewFile ' . g:translation_dir . '/translated.txt' . ' set autoread'

    " - s: function to translate repl file
    function! s:TranslateRepl()
        if &modified
            silent write
            silent! exec '!translate "$(< ' . g:toBeTranslate_file . ')" > /tmp/oddtranslate && cat /tmp/oddtranslate > ' . g:translation_dir . '/translated.txt'
        endif
    endfunction

    " - function to add count to translate for repl
    let g:translate_count=0
    " call s:TranslateRepl() if this method is called translateCount times
    " This method is called with the help of autocmd
    " translation output will be redirect to
    " g:translation_dir/translated.txt
    " Use watch -t -n 0.3 cat translated.txt to watch for test
    function! TranslateCount(translateCount)
        if g:translate_count >= a:translateCount
            let g:translate_count=0
            call s:TranslateRepl()
        else
            let g:translate_count=g:translate_count + 1
        endif
    endfunction

    " - map SPC hr to start repl translation
    nnoremap <space>hr :exec 'e ' . g:toBeTranslate_file<CR><c-w><c-o>:vs<CR><C-w>l:exec 'e ' . g:translation_dir . '/translated.txt'<CR><c-w>h

    " - function to translate region
    function! Translate()
        " let g:abcd=substitute(@v,"\'","\\'","g")
        let s:translate_string=substitute(@v,"\'","","g")
        let s:translate_string=substitute(s:translate_string,"\n",'    ',"g")
        exec "!translate '" . s:translate_string . "'"
        " exec "!translate '" . @v . "'"
    endfunction

    " - map SPC hc to translate
    " vnoremap <silent> <c-h>c :<C-u>Ydv<CR>
    nnoremap <silent> <Space>hc :<C-u>Ydc<CR>
    vnoremap <silent> <Space>hc "vy :call Translate()<CR>
    noremap <Space>htc :<C-u>Yde<CR>

" ***********************************************************************
" 9.2_Vim-multiple-cursor
" ***********************************************************************

    " let g:VM_no_meta_mappings=0
    " - enable mouse for vim-multiple-cursor
    let g:VM_mouse_mappings = 1
    " - clear default mappings of vim-multiple-cursor
    let g:VM_maps = {}
    " - map of mouse for vim-multiple-cursor
    let g:VM_maps["Mouse Cursor"]               = '<C-LeftMouse>'
    let g:VM_maps["Mouse Word"]                 = '<C-RightMouse>'
    let g:VM_maps["Mouse Column"]               = '<M-C-RightMouse>'

    " - map g/ to start regex search for vim-multiple-cursor
    let g:VM_maps["Start Regex Search"]         = 'g/'
    " It is normal mode map
    let g:VM_maps["Visual Regex"]               = 'g/'

    " - map M-j/M-k to add cursor down/up for vim-multiple-cursor
    let g:VM_maps["Add Cursor Down"]            = '<A-J>'
    let g:VM_maps["Add Cursor Up"]              = '<A-K>'

    " - map 1 to add increasing numbers for vim-multiple-cursor
    let g:VM_maps["Numbers"]                    = '1'

    " - map M-a to select all occurence in normal mode for vim-multiple-cursor
    let g:VM_maps["Select All"]                 = '<A-A>'

    " - Select all that match visual selection (it is a visual map)
    let g:VM_maps["Visual All"]                 = '<A-A>'

    " - map z< to align char for vim-multiple-cursor
    let g:VM_maps["Align Char"]                 = 'z<'

    " map C-n to find next occurence for vim-multiple-cursor
    " let g:VM_maps["Find Under"]                 = '<c-n>'
    " let g:VM_maps["Find Subword Under"]         = '<c-n>'
    " q skip current selection

" ***********************************************************************
" 9.3_Tagbar & NERDTree
" ***********************************************************************

    " - map SPC 0 to toggle nerdtree
    nnoremap <Space>0 :call CloseMaximize()<CR>:NERDTreeToggle<CR>

    " - map SPC fp to find current file in nerdtree
    nnoremap <Space>fp :call CloseMaximize()<CR>:NERDTreeFind<CR>

    " - map SPC <enter>/M-m to toggle tagbar
    nnoremap <Space><CR> :TagbarToggle<CR>
    nnoremap <A-m> :TagbarToggle<CR>

    " - order tags by order in the file instead of by name. Press s to toggle.
    let g:tagbar_sort = 0

" ***********************************************************************
" 9.4_Git
" ***********************************************************************

    " - map SPC gs to show git status
    nnoremap <Space>gs :Gstatus<CR>
    " in Gstatus window:
    " -	        add/reset file (works in visual mode too)
    " <Enter>	open current file in the window below
    " p	        run `git add –patch` for current file
    " cc        invoke :Gcommit (Then ZZ to save and commit)
    " c?        Show help

    " - map SPC gd to show git difference
    nnoremap <Space>gd :Gvdiffsplit<CR>
    " - map SPC gc to commit for git
    nnoremap <Space>gc :Gcommit<CR>

    " - map SPC gfm/SPC gfr to move/remove for git
    nnoremap <Space>gfm :Gmove<CR>
    nnoremap <Space>gfr :Gremove<CR>

    " - map SPC gl to show git history
    nnoremap <Space>gl :let g:glog_cursor=line(".")<CR>:0Glog<CR>
    " - map to show next/previous history in git history mode
    nnoremap <Space>gn :cnext<CR>
    nnoremap [q :cnext<CR>
    nnoremap <Space>gp :cprev<CR>
    nnoremap ]q :cprev<CR>
    nnoremap <Space>gN :cprev<CR>

    " - some other mappings for git
    " revert current file
    nnoremap <Space>gr :Gread<CR>
    " stage current file
    nnoremap <Space>ga :Gwrite<CR>
    " show commit time
    nnoremap <Space>gb :Gblame<CR>

    " - move to the same line when swithing in git history mode
    au! BufLeave  fugitive://*  let g:glog_cursor=line(".")
    " au! BufEnter  fugitive://*  exec g:glog_cursor 
    au! BufEnter  fugitive://*  exec "if exists('g:glog_cursor')\n exec g:glog_cursor\n endif\n"

" ***********************************************************************
" 9.5_Fuzzy search
" ***********************************************************************


" ***********************************************************************
" 9.5.1_Fzf
" ***********************************************************************

    " - this is the default extra key bindings for fzf
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-f': 'read @/',
      \}

    " - layout for fzf
    " - down / up / left / right
    let g:fzf_layout = { 'up': '~40%' }

    " - in Neovim, you can set up fzf window using a Vim command
    let g:fzf_layout = { 'window': 'enew' }
    let g:fzf_layout = { 'window': '-tabnew' }
    let g:fzf_layout = { 'window': 'belowright 10split enew' }

    " - customize fzf colors to match your color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

    " - enable per-command history for fzf
    " CTRL-N and CTRL-P will be automatically bound to next-history and
    " previous-history instead of down and up. If you don't like the change,
    " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
    let g:fzf_history_dir = '~/.local/share/fzf-history'

    " - command to search help (FindActions) with fzf
    command! -bang -nargs=* FindActions
      \ call fzf#vim#grep(
      \   'cat $HOME/Software/vim/vim_tip/find_actions '.shellescape(<q-args>), 1)

    " - command to preview and open project file with fzf
    command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse']}), <bang>0)

    command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>,
    \ <bang>0 ? fzf#vim#with_preview('up:60%')
    \ : fzf#vim#with_preview('right:50%:hidden', '?'),
    \ <bang>0)

    command! -nargs=* -bang AgCurrentFile 
    \ call fzf#vim#grep(
    \ 'cat_to_fzf_ag_format ' . expand('%') ,
    \ 0,
    \ fzf#vim#with_preview({'options': '--layout=reverse'},'up:60%'),
    \ <bang>0)


    " - function to show changes of current files with fzf
    function! Changes_results(query,fullscreen)
        redir! > ~/Software/vim/odd_txt_for_vim.txt
        silent changes
        redir end
        exec "silent !~/Software/vim/format_help/format_for_changes " . expand("%")

        call fzf#vim#grep(
        \ 'cat ~/Software/vim/odd_txt_for_vim.txt ' , 0,fzf#vim#with_preview({'options': '--layout=reverse'},'up:60%'), a:fullscreen)
    endfunction
    " - command to show changes of current files with fzf
    command! -nargs=* -bang SearchChanges call Changes_results(<q-args>, <bang>0)

    " - function to show jumps location with fzf
    function! Jumps_results(query,fullscreen)
        redir! > ~/Software/vim/odd_txt_for_vim.txt
        silent jumps
        redir end
        exec "silent !~/Software/vim/format_help/format_for_jumps " . expand("%")

        call fzf#vim#grep(
        \ 'cat ~/Software/vim/odd_txt_for_vim.txt ' , 0,fzf#vim#with_preview({'options': '--layout=reverse'},'up:60%'), a:fullscreen)
    endfunction
    " - command to show jumps location with fzf
    command! -nargs=* -bang JumpsResults call Jumps_results(<q-args>, <bang>0)

    " - command to show most recent file with fzf
    command! -bang -nargs=* FzfMrf call fzf#vim#history(fzf#vim#with_preview({'options': '--layout=reverse'},<bang>0?'up:65%':'right:50%'),<bang>0)

    " - s: function to get buffers name list
    function! s:buffer_list()
      let l:list = filter(range(1, bufnr('$')),
      \ "bufexists(v:val) && buflisted(v:val) && filereadable(expand('#' . v:val . ':p'))"
      \ )
      let l:buflist = map(l:list, 'bufname(v:val)')
      let l:bufname_i=l:buflist[0]
      let l:current_buf_name=bufname("%")
      let l:previous_buf_name=bufname("#")
      bufdo let b:current_line=line('.')
      let l:bufnames_string = l:buflist[0] . ':' . getbufvar(l:bufname_i,"current_line") . ':'
      for l:bufname_i in l:buflist[1:]
          let l:bufnames_string = l:bufnames_string . '\n' . l:bufname_i . ':' . getbufvar(l:bufname_i,"current_line")  . ':'
      endfor
      bufdo unlet b:current_line
      exec "buffer " . l:previous_buf_name
      exec "buffer " . l:current_buf_name

      " return map(l:list, 'bufname(v:val)')
      return l:bufnames_string
    endfunction

    " - function to show buffers with fzf
    function! Fzf_buffers(query,fullscreen)
      call fzf#vim#grep(
      \ "echo '" . s:buffer_list() . "'" , 0,fzf#vim#with_preview({'options': '--layout=reverse'},'up:65%'), a:fullscreen)
    endfunction
    " - command to show buffers with fzf
    command! -nargs=* -bang FzfBuffers call Fzf_buffers(<q-args>, <bang>0)

    " - map SPC hk to search keymap definition
    nmap <space>hk <plug>(fzf-maps-n)
    xmap <space>hk <plug>(fzf-maps-x)
    omap <space>hk <plug>(fzf-maps-o)
    imap <a-m>hk <plug>(fzf-maps-i)

    " - map for insert mode completion with fzf
    imap <c-x>w <plug>(fzf-complete-word)
    imap <c-x>f <plug>(fzf-complete-path)
    imap <c-x>j <plug>(fzf-complete-file-ag)
    imap <c-x>l <plug>(fzf-complete-line)

" ***********************************************************************
" 9.5.2_Ctrlp
" ***********************************************************************

    " - ctrlp extensions
    let g:ctrlp_extensions = [ 'line' ]

    " nnoremap <c-f> :CtrlPLine %<CR>
    " - map C-p to ctrlp
    nmap <c-p> :CtrlP .<CR>
    " let g:ctrlp_map = '<c-p>'

    " - set current working directory for ctrlp
    let g:ctrlp_working_path_mode=2

    " - let ctrlp search hidden files
    let g:ctrlp_show_hidden = 1

" ***********************************************************************
" 9.6_Easymotion
" ***********************************************************************

    " - set prefix for easymotion
    map <Leader> <Plug>(easymotion-prefix)

    " - mappings for easymotion
    " nmap s <Plug>(easymotion-jumptoanywhere)
    nmap \j <Plug>(easymotion-bd-jk)
    nmap \k <Plug>(easymotion-bd-jk)
    nmap \w <Plug>(easymotion-bd-w)
    nmap \n <Plug>(easymotion-bd-n)
    nmap \f <Plug>(easymotion-overwin-f)

" ***********************************************************************
" 9.7_TCommentO
" ***********************************************************************

    let g:tcomment_opleader1="<space>;"
    nnoremap <space>;;  :TComment<CR>

" ***********************************************************************
" 9.8_Scratch
" ***********************************************************************

    " this tool creates scratch file to edit for free
    let g:scratch_persistence_file = "$HOME/Software/vim/Scratch"
    let g:scratch_no_mappings = 1
    let g:scratch_height = 15
    let g:scratch_autohide = 0

" ***********************************************************************
" 9.9_snippets
" ***********************************************************************

    " - snippets of vim-snippets are in folders under:
    " ~/.vim/plugged/vim-snippets/UltiSnips
    " ~/.vim/plugged/vim-snippets/snippets
    "
    " - custom snippets are in folders under:
    " ~/Software/vim/plugins/mysnippets/UltiSnips/
    " Use :OpenMySnippets to edit custom snippet with current file type.
    " Note that ultisnips use `command` to call bash command.
    " And use `!p snip.rv = command` to call python command

    " - map to trigger configuration
    " Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<c-v>"

    " - map to jump forward/backward in snips
    let g:UltiSnipsJumpForwardTrigger="<c-f>"
    let g:UltiSnipsJumpBackwardTrigger="<c-b>"

    " - split your window when :UltiSnipsEdit 
    let g:UltiSnipsEditSplit="vertical"

    " - snip style for python
    "doxygen" sphinx" google" numpy" jedi" 
    let g:ultisnips_python_style="numpy"

    " - snip meta data
    let g:snips_author='zky'
    let g:snips_email='739521505@qq.com'
    let g:snips_github='https://github.com/asfsdsf'

" ***********************************************************************
" 9.10_Vim-expand-region
" ***********************************************************************

    nmap <a-w> <Plug>(expand_region_expand)
    xmap v <Plug>(expand_region_expand)
    xmap V <Plug>(expand_region_shrink)

    " Default value of g:expand_region_text_objects={'ie':0,'ip':0,'iw':0,'iB':1,'il':0,'iW':0,'i''':0,'ib':1,'i]':1,'i"':0}
    " 1 means recursive.
    " See more with :help expand_region
    let g:expand_region_text_objects={'ip':0,'iw':0,'iB':1,'aB':1,'ab':1,'iW':0,'a''':0,'ib':1,'a]':1,'a"':0}

" ***********************************************************************
" 9.11_Ranger
" ***********************************************************************

    " Interactive with ranger - a file manager installed by sudo apt install ranger

    " Start ranger using ":RangerChooser" or the keybinding "<Space>r".  Once you
    " select one or more files, press enter and ranger will quit again and vim 
    " will open the selected files.

    function! RangeChooser()
        let temp = tempname()
        " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
        " with ranger 1.4.2 through 1.5.0 instead.
        "exec 'silent !ranger --choosefile=' . shellescape(temp)
        if has("gui_running")
            exec 'silent !xterm -e ranger --choosefiles=' . shellescape(temp)
        else
            exec 'silent !ranger --choosefiles=' . shellescape(temp)
        endif
        if !filereadable(temp)
            redraw!
            " Nothing to read.
            return
        endif
        let names = readfile(temp)
        if empty(names)
            redraw!
            " Nothing to open.
            return
        endif
        " Edit the first item.
        exec 'edit ' . fnameescape(names[0])
        " Add any remaning items to the arg list/buffer list.
        for name in names[1:]
            exec 'argadd ' . fnameescape(name)
        endfor
        redraw!
    endfunction
    command! -bar RangerChooser call RangeChooser()
    nnoremap <Space>r :<C-U>RangerChooser<CR>

" ***********************************************************************
" 9.12_Abbreviation
" ***********************************************************************

    " This is a functionality of vim rather than a plugin

    " - function to set visual region to new abbreviation
    function!VisualSetAbbreviation ()
        cd %:h
        " iabbrev will set abbreviation for insert mode
        let l:abb_name = input('Please input abbreviation: ')

        let l:abb_go_back=""
        " if @v contains @@ substring
        if stridx(@v,"@@")>=0
            let l:abb_go_back="<esc>z?@@<CR>xxi"
        endif

        " let l:visual_region_text=substitute(@v,'|','<bar>','g')
        " let l:visual_region_text=substitute(l:visual_region_text,'\n','<CR>','g')
        " let l:abb_formula = "iabbrev " . l:abb_name . " " . l:visual_region_text . l:abb_go_back

        let l:visual_region_text=substitute(@v,'\n *',"'" . '."\\n".' . "'",'g')
        let l:set_abb_str="let g:myabbr" . l:abb_name . "='" . l:visual_region_text . "'\n"
        exec l:set_abb_str
        let l:abb_formula="iabbrev " . l:abb_name . " <c-r>=" . "g:myabbr" . l:abb_name . "<CR>" .l:abb_go_back
        exec l:abb_formula
        silent call SaveAbbr(l:set_abb_str . l:abb_formula)
    endfunction
    " - map SPC va to set visual region to new abbreviation
    vnoremap <Space>va "vy:call VisualSetAbbreviation()<CR>

    " - function to save abbreviation (to file ./abbrev_defs.vim)
    function! SaveAbbr(abb_formula)
        redir >> ./abbrev_defs.vim
        "foo.txt is the file in which you wish to add your abbreviations. For me, it
        "is ~/.vim/ftplugin/tex.vim
        echo a:abb_formula
        redir END
    endfunction

    " - function to load abbreviation (from file ./abbrev_defs.vim)
    function! LoadAbbr()
        cd %:h
        if filereadable("./abbrev_defs.vim")
            source ./abbrev_defs.vim
        else
            echo "there is no abbrev_defs.vim file in current directory"
        endif
    endfunction
    com! LoadAbbreviations call LoadAbbr()

    " - function to show abbreviation (go to file ./abbrev_defs.vim)
    function! ShowAbbreviations()
        e ./abbrev_defs.vim
    endfunction

    " - map C-c C-c to reload abbreviation when in ./abbrev_defs.vim
    autocmd BufRead,BufNewFile abbrev_defs.vim nnoremap <buffer> <C-c><C-c> :abclear<CR>:source %<CR>

" ***********************************************************************
" 9.13_Undotree
" ***********************************************************************

if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif


" ***********************************************************************
" 9.14_Neomake
" ***********************************************************************

if g:vim_plug_installed

    " automatically make the makefile
    " when writing or reading a buffer, and on changes in insert and normal mode (after 500ms; no delay when writing)
    call neomake#configure#automake('nrwi', 500)
    " disable lint/syntax check
    let g:neomake_python_enabled_makers = []
    let g:neomake_c_enabled_makers = []
    let g:neomake_cpp_enabled_makers = []
    let g:neomake_javascript_enabled_makers = []
endif  " end if g:vim_plug_installed



" Variable used to judge whether it is the first time to source vimrc
" " For example, when you need to
" call airline#add_statusline_func('WindowNumber')
" " this function can only be added once. Hence you can
" if exists('g:vimrc_has_been_sourced')
"     call airline#add_statusline_func('WindowNumber')
" endif 
let g:vimrc_has_been_sourced = 1

