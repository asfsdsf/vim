" This is old vimrc file.
" Switch to vimrc generated by bootstrap from now on.

set nocompatible              " be improved, required
set encoding=utf8 
"""" START Vundle Configuration
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
""" All of your Plugins must be added before the following line

" Utility
Plugin 'file:///home/ban/Software/vim/plugins/toggle_maximize.vim/'  " toggle maximize window
Plugin 'scrooloose/nerdtree'  " file tree
Plugin 'majutsushi/tagbar'  " file names at top bar
Plugin 'ervandew/supertab'  " perform all your vim insert mode completions with Tab
Plugin 'junegunn/fzf.vim'  " fuzzy find
Plugin 'junegunn/fzf'  " fuzzy find together with plugin above
" To recompile YouCompleteMe, run:
" python3 install.py --clang-completer --ts-completer --java-completer
Plugin 'Valloric/YouCompleteMe'  " auto complete engine
Plugin 'rdnetto/YCM-Generator'  " generate .ycm_extra_conf.py file according to CMakeList.txt for YouCompleteMe
Plugin 'davidhalter/jedi-vim'  "Using the jedi autocompletion library for VIM.
Plugin 'benmills/vimux'  " vim plugin to interact with tmux
Plugin 'ctrlpvim/ctrlp.vim'  " Fuzzy file, buffer, mru, tag, etc finder.
" Plugin 'terryma/vim-multiple-cursors'  " Sublime Text style multiple selections for Vim
Plugin 'mg979/vim-visual-multi',  " Sublime Text style multiple selections for Vim
Plugin 'w0rp/ale'  " Syntax checking for python
Plugin 'wellle/targets.vim' " Vim plugin that provides additional text objects
Plugin 'sbdchd/neoformat' " A (Neo)vim plugin for formatting code.
Plugin 'tpope/vim-fugitive' " A git wrapper for vim

" Language support
Plugin 'mattn/emmet-vim'  " for html

" Generic Programming Support
" Plugin 'Raimondi/delimitMate' " enable an auto-close chars feature
" Plugin 'jiangmiao/auto-pairs' " enable an auto-close chars feature
Plugin 'Raimondi/delimitMate'  " enable an auto-close chars feature
Plugin 'tomtom/tcomment_vim'  " extensible & universal comment vim-plugin that also handles embedded filetypes
Plugin 'tpope/vim-surround'  " surround.vim: quoting/parenthesizing made simple
Plugin 'SirVer/ultisnips'  " Track the engine.
Plugin 'honza/vim-snippets'  " Snippets are separated from the engine. Add this if you want them:

" Theme / Interface
Plugin 'vim-airline/vim-airline'  " beautiful bar at bottom
Plugin 'vim-airline/vim-airline-themes'  " beautiful bar at bottom
Plugin 'ryanoasis/vim-devicons'  " iconize symbols
Plugin 'morhetz/gruvbox'  "retro groove color scheme for Vim

" The following theme is copied from https://coderoncode.com/tools/2017/04/16/vim-the-perfect-ide.html
" And I don't clearly know their specific functionality
Plugin 'sjl/badwolf'
Plugin 'tomasr/molokai'
Plugin 'zenorocha/dracula-theme', {'rtp': 'vim/'}
Plugin 'junegunn/limelight.vim'
Plugin 'mkarmona/colorsbox'
Plugin 'romainl/Apprentice'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'chriskempson/base16-vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'AlessandroYorba/Sierra'
Plugin 'daylerees/colour-schemes'
Plugin 'effkay/argonaut.vim'
Plugin 'ajh17/Spacegray.vim'
Plugin 'atelierbram/Base2Tone-vim'
Plugin 'colepeters/spacemacs-theme.vim'



call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"""""""""""""""""""""""""""""""""""""
" Mappings configurationn
"""""""""""""""""""""""""""""""""""""

" set alt map
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

" vim-multiple-cursor Mappings
" let g:multi_cursor_use_default_mapping=0
" let g:multi_cursor_start_word_key      = '<A-j>'
" let g:multi_cursor_select_all_word_key = '<A-n>'
" let g:multi_cursor_start_key           = 'g<A-j>'
" let g:multi_cursor_select_all_key      = 'g<A-n>'
" let g:multi_cursor_next_key            = '<A-j>'
" let g:multi_cursor_prev_key            = '<A-k>'
" let g:multi_cursor_skip_key            = '<A-x>'
" let g:multi_cursor_quit_key            = '<Esc>'

" vim-visual-multi Mappings
let g:VM_no_meta_mappings=0
let g:VM_maps = {}
let g:VM_maps["Select Operator"]          = 'gs'
let g:VM_maps["Add Cursor At Pos"]        = 'g<space>'
let g:VM_maps["Start Regex Search"]       = 'g/'
let g:VM_maps["Select All"]               = '<leader>A'
let g:VM_maps["Add Cursor Down"]          = '<A-j>'
let g:VM_maps["Add Cursor Up"]            = '<A-k>'
let g:VM_maps["Visual Regex"]             = 'g/'
let g:VM_maps["Visual All"]               = '<A-A>'
let g:VM_maps["Visual Add"]               = '<A-a>'
let g:VM_maps["Visual Find"]              = '<C-f>'
let g:VM_maps["Visual Cursors"]           = '<C-c>'
let g:VM_maps["Find Under"]               = '<c-n>'
let g:VM_maps["Find Subword Under"]       = '<c-n>'

map <Space>0 :NERDTreeToggle<CR>
map <C-m> :TagbarToggle<CR>

" YouCompleteMe Mappings
nnoremap <c-b> :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <c-f> :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>q :YcmCompleter GetDoc<CR>
" <c-e> :cancel completion

" Mapping selecting Mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '14%'})
"""""""""""""""""""""""""""""""""""""
" Initialization
"""""""""""""""""""""""""""""""""""""
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"""""""""""""""""""""""""""""""""""""
" display
"""""""""""""""""""""""""""""""""""""
set showcmd                          "show key strokes

" Show linenumbers
set number relativenumber
set ruler " Always show cursor position

" Enable highlighting of the current lines
set cursorline

" Theme and Styling
set t_Co=256
set background=dark

set foldmethod=indent

if (has("termguicolors"))
  set termguicolors
endif

let base16colorspace=256  " Access colors present in 256 colorspace
" colorscheme spacegray
colorscheme spacemacs-theme
" colorscheme gruvbox

let g:spacegray_underline_search = 1
let g:spacegray_italicize_comments = 1

let g:gruvbox_contrast = 'hard'

" Vim-Airline {{{
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline_theme='hybrid'
    let g:hybrid_custom_term_colors = 1
    let g:hybrid_reduced_contrast = 1

    " add window number in front of the airline
    function! WindowNumber(...)
        let builder = a:1
        let context = a:2
        call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
        return 0
    endfunction

    call airline#add_statusline_func('WindowNumber')
    call airline#add_inactive_statusline_func('WindowNumber')
" }}}



" Devicons {{{
    let g:webdevicons_conceal_nerdtree_brackets = 1
    let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
" }}}

"""""""""""""""""""""""""""""""""""""
" custom functin
"""""""""""""""""""""""""""""""""""""
nmap <space>a :FindActions<CR>

function! s:Python_print()
    if expand('%:p')=="/home/ban/Software/vim/python_for_vim.py"
        wq
        r !python /home/ban/Software/vim/python_for_vim.py
    else
        vsplit /home/ban/Software/vim/python_for_vim.py
        execute "normal!ggdG"
"        echo "press P to use last python file"
    endif
endfunction
com! PythonPrint call s:Python_print()

" open and edit find actions file which provide useful keymaps.(Use <Space>a to
" access the keymaps)
com! OpenFindActionsFile 12sp ~/Software/vim/vim_tip/find_actions

com! OpenVimrcDotFile vs ~/.vimrc

com! OpenTodoFile 12sp ~/Software/vim/TODO

com! OpenFlake8Config 12sp ~/.config/flake8

function! g:OpenFileByCtrlP()
    let @p=expand('%:p:h')
    exec "CtrlP %"
endfunction
nnoremap <Space>ff :call OpenFileByCtrlP()<CR>

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! s:Compared_with_clipboard()
    diffthis
    vnew ~/Software/vim/clipboard
    execute 'normal!gg"_dG"+P'
    diffthis
endfunction
com!CompareClipboard call s:Compared_with_clipboard()
" exit diff mode after closing clipboard
autocmd QuitPre ~/Software/vim/clipboard :diffoff
" auto update difference
autocmd TextChanged ~/Software/vim/clipboard :diffupdate

autocmd FileType python nnoremap <buffer> <Space>r :w <bar> !/home/ban/Programming/Python/Anaconda/bin/python %<CR>


" autocmd InsertLeave * :update

" nnoremap <c-w><c-o> :call MaximizeToggle()<CR>
" nnoremap <c-w><o> :call MaximizeToggle()<CR>

" directly use s to perform surround
nmap s ys

" Moving in insert mode

inoremap <A-h> <c-left>
inoremap <A-j> <c-o>o
inoremap <A-k> <c-o>O
inoremap <A-l> <c-right>

inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>

inoremap <c-a> <c-o>^
inoremap <c-e> <c-o>$

inoremap <c-p> <c-o>p
inoremap <c-d> <c-o>d
inoremap <c-y> <c-o>y

" Easier moving in tabs and windows
nnoremap <A-right> gt
nnoremap <A-left> gT
nnoremap <A-J> <C-W>j
nnoremap <A-K> <C-W>k
nnoremap <A-L> <C-W>l
nnoremap <A-H> <C-W>h

nnoremap Y "+y
nnoremap D "+d

nnoremap <Space>sf :Ag<CR>
" inoremap <s-Enter> <Esc>o

" map for replacement
nnoremap <c-h> :%s//gc<left><left><left>
cnoremap <c-h> <CR>:%s///gc<left><left><left>

"""""""""""""""""""""""""""""""""""""
" Map from spacemacs
"""""""""""""""""""""""""""""""""""""
" nunmap <Space>
nnoremap <Space>wh <C-w>h
nnoremap <Space>wj <C-w>j
nnoremap <Space>wk <C-w>k
nnoremap <Space>wl <C-w>l
nnoremap <Space>wH <C-w>H
nnoremap <Space>wJ <C-w>J
nnoremap <Space>wK <C-w>K
nnoremap <Space>wL <C-w>L
nnoremap <Space>w/ :vs<CR>
nnoremap <Space>w- :sp<CR>
nnoremap <Space>ww <C-w>w
nnoremap <Space>w= <C-w>=
nnoremap <Space>wd :close<CR>
nnoremap <Space>wx :bd<CR>:close<CR>
nnoremap <Space>wo <C-w><C-o>
nnoremap <c-down>  2<C-w>-
nnoremap <c-up>    2<C-w>+
nnoremap <c-left>  2<C-w><
nnoremap <c-right> 2<C-w>>
nnoremap <Space>1  1<C-w><C-w>
nnoremap <Space>2  2<C-w><C-w>
nnoremap <Space>3  3<C-w><C-w>
nnoremap <Space>4  4<C-w><C-w>
nnoremap <Space>5  5<C-w><C-w>
nnoremap <Space>6  6<C-w><C-w>
nnoremap <Space>7  7<C-w><C-w>
nnoremap <Space>8  8<C-w><C-w>
nnoremap <Space>9  9<C-w><C-w>
nnoremap <Space>fr :CtrlPMRUFiles<CR>
" nnoremap <Space>ff :CtrlP %<CR>
nnoremap <Space>ss :CtrlPLine %<CR>
nnoremap <Space><Tab> :b#<CR>
nnoremap ]e        :move +1<CR>
nnoremap [e        :move -2<CR>
nnoremap <Space><Space> :
nnoremap <Space>fvd :OpenVimrcDotFile<CR>
nnoremap <Space>fvR :source ~/.vimrc<CR>
nnoremap <Space>mcc :w<CR>:!python %<CR>
nnoremap <Space>bd :bd<CR>
nnoremap <Space>bn :bn<CR>
nnoremap <Space>bp :bp<CR>
nnoremap <Space>bb :CtrlPBuffer<CR>
nnoremap <Space>bx :bd<CR>:close<CR>
nnoremap <Space>qq :qa<CR>
nnoremap <Space>hd :help 

"""""""""""""""""""""""""""""""""""""
" Configuration Section
"""""""""""""""""""""""""""""""""""""
" smart case for / search
set ignorecase
set smartcase

" highlight all search matches
:set hlsearch

" highlight the next match while you're still typing out your search pattern
:set hlsearch incsearch

" set more visual hints in command-line mode
set wildmenu

" Indention Options
set autoindent " New lines inherit the indentation of previous lines
set expandtab " Convert tabs to spaces
set shiftwidth=4 " When shifting, indent using four spaces
set tabstop=4 " Indent using four spaces
set smarttab
set expandtab

" Enable hidden buffers
set hidden

" make scroll leave a margin for 3 lines
set scrolloff=3

" set updatetime to 1 second.This is used for CursorHold event
set updatetime=1000



" Elixir {{{
    let g:tagbar_type_elixir = {
        \ 'ctagstype' : 'elixir',
        \ 'kinds' : [
            \ 'f:functions',
            \ 'functions:functions',
            \ 'c:callbacks',
            \ 'd:delegates',
            \ 'e:exceptions',
            \ 'i:implementations',
            \ 'a:macros',
            \ 'o:operators',
            \ 'm:modules',
            \ 'p:protocols',
            \ 'r:records',
            \ 't:tests'
        \ ]
        \ }
" }}}



" YouCompleteMe {{{
    " To recompile YouCompleteMe:
    " python3 install.py --clang-completer --ts-completer --java-completer
    " open keyword completion
    let g:ycm_seed_identifiers_with_syntax=1
    "blacklist for youcompleteme
    let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'gitcommit' : 1,
            \}
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
" }}}



" Fzf {{{ 
    " This is the default extra key bindings
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

    " Default fzf layout
    " - down / up / left / right
    let g:fzf_layout = { 'up': '~40%' }

    " In Neovim, you can set up fzf window using a Vim command
    let g:fzf_layout = { 'window': 'enew' }
    let g:fzf_layout = { 'window': '-tabnew' }
    let g:fzf_layout = { 'window': 'belowright 10split enew' }

    " Customize fzf colors to match your color scheme
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

    " Enable per-command history.
    " CTRL-N and CTRL-P will be automatically bound to next-history and
    " previous-history instead of down and up. If you don't like the change,
    " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
    let g:fzf_history_dir = '~/.local/share/fzf-history'

    " help search command 
    command! -bang -nargs=* FindActions
      \ call fzf#vim#grep(
      \   'cat /home/ban/Software/vim/vim_tip/find_actions '.shellescape(<q-args>), 1)
" }}}



" CtrlP {{{
    let g:ctrlp_extensions = [ 'line' ]
    nnoremap <c-f> :CtrlPLine %<CR>
    nmap <c-p> :CtrlP .<CR>
    " let g:ctrlp_map = '<c-p>'
    let g:ctrlp_working_path_mode=2
    let g:ctrlp_show_hidden = 1
" }}}



" {{{ ale
    " let g:ale_sign_error = '✗'
    " let g:ale_sign_warning = '⚠'
    " " suppress the display of errors when you move the cursor onto their line (prevent cursor from disappearing)
    " let g:ale_echo_cursor = 0

    nmap <silent> <Space>ep <Plug>(ale_previous_wrap)
    nmap <silent> <Space>eN <Plug>(ale_previous_wrap)
    nmap <silent> <Space>en <Plug>(ale_next_wrap)

    " Available Linters: 'flake8', 'mypy', 'prospector', 'pycodestyle', 'pyflakes', 'pylint', 'pyls', 'pyre', 'vulture'
    let g:ale_linters = {
    \   'python': ['flake8','pylint'],
    \}

    let g:ale_fixer= {
    \   'python': ['autopep8'],
    \}

    " to suppress errors by flake8 globally,use OpenFlake8Config
    " add at the end of the error line `# noqa EXXX` XXX is num to suppress an
    " error there
" }}}



" {{{ flake8
    " let g:flake8_show_in_gutter=1  " show signs in the gutter
    " let g:flake8_show_in_file=1  " show marks in the file
" }}}



" {{{ snippets
    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<c-v>"
    let g:UltiSnipsJumpForwardTrigger="<c-f>"
    let g:UltiSnipsJumpBackwardTrigger="<c-b>"

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"
" }}}
"
