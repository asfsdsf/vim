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
Plugin 'scrooloose/nerdtree'  " file tree
Plugin 'majutsushi/tagbar'  " file names at top bar
Plugin 'ervandew/supertab'  " perform all your vim insert mode completions with Tab
Plugin 'junegunn/fzf.vim'  " fuzzy find
Plugin 'junegunn/fzf'  " fuzzy find together with plugin above
Plugin 'Valloric/YouCompleteMe'  " auto complete engine
Plugin 'benmills/vimux'  " vim plugin to interact with tmux
Plugin 'ctrlpvim/ctrlp.vim'

" Language support
Plugin 'mattn/emmet-vim'  " for html

" Generic Programming Support
Plugin 'Townk/vim-autoclose'  " enable an auto-close chars feature
Plugin 'tomtom/tcomment_vim'  " extensible & universal comment vim-plugin that also handles embedded filetypes

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
"filetype plugin on
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

map <A-q> <Esc><Esc><Esc><Esc>
map <C-n> :NERDTreeToggle<CR>
map <C-m> :TagbarToggle<CR>

" YouCompleteMe Mappings
nnoremap <c-f> :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <c-b> :YcmCompleter GoToDeclaration<CR>

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
set number
set ruler " Always show cursor position

" Enable highlighting of the current lines
set cursorline

" Theme and Styling
set t_Co=256
set background=dark

if (has("termguicolors"))
  set termguicolors
endif

let base16colorspace=256  " Access colors present in 256 colorspace
" colorscheme spacegray
" colorscheme spacemacs-theme
colorscheme gruvbox

let g:spacegray_underline_search = 1
let g:spacegray_italicize_comments = 1

let g:gruvbox_contrast = 'hard'

" Vim-Airline {{{
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline_theme='hybrid'
    let g:hybrid_custom_term_colors = 1
    let g:hybrid_reduced_contrast = 1
" }}}



" Devicons {{{
    let g:webdevicons_conceal_nerdtree_brackets = 1
    let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
" }}}

"""""""""""""""""""""""""""""""""""""
" custom functin
"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""
" Configuration Section
"""""""""""""""""""""""""""""""""""""
" smart case for / search
set ignorecase
set smartcase

" highlight all search matches
:set hlsearch

" set more visual hints in command-line mode
set wildmenu

" Indention Options
set autoindent " New lines inherit the indentation of previous lines
set expandtab " Convert tabs to spaces
set shiftwidth=4 " When shifting, indent using four spaces
set tabstop=4 " Indent using four spaces
set smarttab
set expandtab

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
    " open keyword completion
    let g:ycm_seed_identifiers_with_syntax=1
    "blacklist for youcompleteme
    let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'gitcommit' : 1,
            \}
" }}}



" Fzf {{{ 
    " This is the default extra key bindings
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

    " Default fzf layout
    " - down / up / left / right
    let g:fzf_layout = { 'down': '~40%' }

    " In Neovim, you can set up fzf window using a Vim command
    let g:fzf_layout = { 'window': 'enew' }
    let g:fzf_layout = { 'window': '-tabnew' }

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
" }}}
