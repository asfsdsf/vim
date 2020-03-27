if has('nvim')
    let b:plug_path='~/.nvim/plugged'
    let b:dot_file_path='~/Software/vim/vimrc'
else
    let b:plug_path='~/.vim/plugged'
    let b:dot_file_path='~/Software/vim/vimrc'
endif

set nocompatible              " be improved, required
set encoding=utf8 
"""" START vim-plug Configuration

" set the runtime path to include vim-plug and initialize
call plug#begin(b:plug_path)
""" All of your Plugins must be added before the following line

" Utility
Plug '~/Software/vim/plugins/toggle_maximize.vim/'  " toggle maximize window
Plug 'scrooloose/nerdtree'  " file tree
Plug 'majutsushi/tagbar'  " file names at top bar
Plug 'ervandew/supertab'  " perform all your vim insert mode completions with Tab
Plug 'junegunn/fzf.vim'  " fuzzy find
Plug 'junegunn/fzf'  " fuzzy find together with plugin above
Plug 'easymotion/vim-easymotion'  " Vim motions on speed! http://www.vim.org/scripts/script.php…
Plug 'mbbill/undotree'  " show undo history
" To recompile YouCompleteMe, run:
" python3 install.py --clang-completer --ts-completer --java-completer
" python3 install.py --clangd-completer --ts-completer --java-completer
" Note that clangd is still in heavy development.
" in ~/.vim/plugged/YouCompleteMe for vim
" in ~/.nvim/plugged/YouCompleteMe for nvim
Plug 'Valloric/YouCompleteMe'  " auto complete engine
Plug 'JuliaEditorSupport/julia-vim'  " Vim support for Julia. http://julialang.org/
" generate .ycm_extra_conf.py file according to CMakeList.txt for YouCompleteMe
Plug 'rdnetto/YCM-Generator',{ 'branch': 'develop'} 
Plug 'lervag/vimtex'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}  " Interactive command execution in Vim.
Plug 'Shougo/deol.nvim'  " shell interface for NeoVim and Vim8.
" Plug 'Shougo/vimshell.vim'  " shell interface for NeoVim and Vim8.
Plug 'benmills/vimux'  " vim plugin to interact with tmux
Plug 'christoomey/vim-tmux-navigator'  " Seamless navigation between tmux panes and vim splits
Plug 'ctrlpvim/ctrlp.vim'  " Fuzzy file, buffer, mru, tag, etc finder.
" Plug 'terryma/vim-multiple-cursors'  " Sublime Text style multiple selections for Vim
Plug 'mg979/vim-visual-multi',  " Sublime Text style multiple selections for Vim
Plug 'terryma/vim-expand-region'  " Expand region like emacs
Plug 'mtth/scratch.vim'  " Unobtrusive scratch window
" Plug 'w0rp/ale'  " Syntax checking for python
if has('nvim')
    Plug 'sakhnik/nvim-gdb', { 'do': ':UpdateRemotePlugins' }
else
    packadd termdebug
endif
Plug 'Chiel92/vim-autoformat'  " Provide easy code formatting in Vim by integrating existing code formatters.
Plug 'neomake/neomake'  " Asynchronous linting and make framework for Neovim/Vim (auto async make)
Plug 'wellle/targets.vim' " Vim plugin that provides additional text objects
Plug 'sbdchd/neoformat' " A (Neo)vim plugin for formatting code.
Plug 'tpope/vim-fugitive' " A git wrapper for vim
Plug 'airblade/vim-gitgutter'  " A Vim plugin which shows a git diff in the sign column and stages/previews/undoes hunks and partial hunks.
Plug 'Xuyuanp/nerdtree-git-plugin'  " A plugin of NERDTree showing git status
Plug 'ianva/vim-youdao-translater' " translation plugin for vim  http://ianva.github.com

" Language support
Plug 'mattn/emmet-vim'  " for html

" Generic Programming Support
" Plug 'Raimondi/delimitMate' " enable an auto-close chars feature
" Plug 'jiangmiao/auto-pairs' " enable an auto-close chars feature
Plug 'Raimondi/delimitMate'  " enable an auto-close chars feature
Plug 'tomtom/tcomment_vim'  " extensible & universal comment vim-plugin that also handles embedded filetypes
Plug 'tpope/vim-surround'  " surround.vim: quoting/parenthesizing made simple
Plug 'SirVer/ultisnips'  " Track the engine.
Plug 'honza/vim-snippets'  " Snippets are separated from the engine. Add this if you want them:

" Theme / Interface
Plug 'vim-airline/vim-airline'  " beautiful bar at bottom
Plug 'vim-airline/vim-airline-themes'  " beautiful bar at bottom
Plug 'ryanoasis/vim-devicons'  " iconize symbols
Plug 'morhetz/gruvbox'  "retro groove color scheme for Vim
Plug 'mhinz/vim-startify'  " The fancy start screen for Vim.

" The following theme is copied from https://coderoncode.com/tools/2017/04/16/vim-the-perfect-ide.html
" And I don't clearly know their specific functionality
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}
Plug 'junegunn/limelight.vim'
Plug 'mkarmona/colorsbox'
Plug 'romainl/Apprentice'
Plug 'Lokaltog/vim-distinguished'
Plug 'chriskempson/base16-vim'
Plug 'w0ng/vim-hybrid'
Plug 'AlessandroYorba/Sierra'
Plug 'daylerees/colour-schemes'
Plug 'effkay/argonaut.vim'
Plug 'ajh17/Spacegray.vim'
Plug 'atelierbram/Base2Tone-vim'
Plug 'colepeters/spacemacs-theme.vim'


" required
call plug#end()
" Put your non-Plugin stuff after this line
"""""""""""""""""""""""""""""""""""""
" Initialization
"""""""""""""""""""""""""""""""""""""
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"""""""""""""""""""""""""""""""""""""
" display
"""""""""""""""""""""""""""""""""""""
set showcmd                          "show key strokes

" Show linenumbers
set number relativenumber
set ruler " Always show cursor position

" Enable highlighting of the current lines
set cursorline

" make sure column line will be preserved when swiching buffer
set nostartofline

" Theme and Styling
set t_Co=256
set background=dark

set foldmethod=indent
set foldnestmax=10
set nofoldenable

set mouse=a

" conflict config for nvim and vim
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

if (has("termguicolors"))
  set termguicolors
endif

" color conflict with TERMINOLOGY
if exists("$TERMINOLOGY")
    set notermguicolors
endif

let base16colorspace=256  " Access colors present in 256 colorspace
" colorscheme spacegray
" colorscheme spacemacs-theme
colorscheme gruvbox

let g:spacegray_underline_search = 1
let g:spacegray_italicize_comments = 1

" let g:gruvbox_contrast_dark = 'hard'

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

" open and edit find actions file which provide useful keymaps.(Use <Space>aa to
" access the keymaps)
com! OpenFindActionsFile 12sp ~/Software/vim/vim_tip/find_actions

execute "com! OpenVimrcDotFile e " . b:dot_file_path

com! OpenTodoFile 12sp ~/Software/vim/TODO

com! OpenFlake8Config 12sp ~/.config/flake8

function! g:OpenFileByCtrlP()
    12sp $HOME/Software/vim/open_file_help.sh
    exec "normal! \<c-w>J"
    r!pwd
    exec "normal!k\"pdd"
    startinsert!
endfunction
nnoremap <Space>ff :call OpenFileByCtrlP()<CR>
nnoremap <Space>pf :Files!<CR>

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! s:OpenDirectoryFile(dir_path)
    12sp $HOME/Software/vim/open_file_help.sh
    exec "normal! \<c-w>J"
    put =a:dir_path
    exec "normal!k\"pdd"
    startinsert!
endfunction
com!OpenSoftwareInstallRecord call s:OpenDirectoryFile('~/Documents/Notes/software_installation_record')
com!OpenProgrammingNotes call s:OpenDirectoryFile('~/Documents/Notes/programming')
com!OpenCustomCommand call s:OpenDirectoryFile('~/Programming/shell/command')
com!OpenBashComplete call s:OpenDirectoryFile('~/Programming/shell/autocomplete/my_complete')
com!OpenZshComplete call s:OpenDirectoryFile('~/Software/zsh/completion')
com!OpenGraduateStudy call s:OpenDirectoryFile('~/Documents/learn/study')

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

" Goto (nth_add_1 - 1)  buffer shown in top bar
function! g:GotoNthBuffer(nth_add_1)
    " let g:previous_buf_name=bufname("#")
    bfirst
    exec a:nth_add_1 . "bn"
    " let g:current_buf_name=bufname("%")
    " exec "buffer " . g:previous_buf_name
    " exec "buffer " . g:current_buf_name
endfunction

"""""""""""""""""""""""""""""""""""""
" Basic mappings configurationn
"""""""""""""""""""""""""""""""""""""

"{{{ vim-multiple-cursor Mappings 
    " vim-visual-multi Mappings
    " let g:VM_no_meta_mappings=0
    let g:VM_mouse_mappings = 1
    let g:VM_maps = {}
    let g:VM_maps["Mouse Cursor"]                = '<C-LeftMouse>'
    let g:VM_maps["Mouse Word"]                  = '<C-RightMouse>'
    let g:VM_maps["Mouse Column"]                = '<M-C-RightMouse>'
    " let g:VM_maps["Select Operator"]          = 'gs'
    " let g:VM_maps["Add Cursor At Pos"]        = 'g<space>'
    " let g:VM_maps["Start Regex Search"]       = 'g/'
    " let g:VM_maps["Select All"]               = '<leader>A'
    let g:VM_maps["Add Cursor Down"]            = '<A-C-j>'
    let g:VM_maps["Add Cursor Up"]              = '<A-C-k>'
    let g:VM_maps["Numbers"]                    = '<A-n>'
    let g:VM_maps["Visual Regex"]               = 'g/'
    " let g:VM_maps["Visual All"]               = '<A-A>'
    " let g:VM_maps["Visual Add"]               = '<A-a>'
    " let g:VM_maps["Visual Find"]              = '<C-f>'
    " let g:VM_maps["Visual Cursors"]           = '<C-c>'
    " let g:VM_maps["Find Under"]               = '<c-n>'
    " let g:VM_maps["Find Subword Under"]       = '<c-n>'
    if has('nvim')

    else
        
    endif
    vmap <A-j> g/^<CR><tab>

"}}}


"{{{ tagbar & NERDTree
    map <Space>0 :call CloseMaximize()<CR>:NERDTreeToggle<CR>
    map <Space><CR> :TagbarToggle<CR>
    map <A-m> :TagbarToggle<CR>
"}}}


"{{{ fugitive Mappings
    " git status
    nnoremap <Space>gs :Gstatus<CR>
    " in Gstatus window:
    " -	        add/reset file (works in visual mode too)
    " <Enter>	open current file in the window below
    " p	        run `git add –patch` for current file
    " C	        invoke :Gcommit
    nnoremap <Space>gd :Gvdiffsplit<CR>
    nnoremap <Space>gc :Gcommit<CR>
    nnoremap <Space>gfm :Gmove<CR>
    nnoremap <Space>gfr :Gremove<CR>
    " revert current file
    nnoremap <Space>gr :Gread<CR>
    " stage current file
    nnoremap <Space>ga :Gwrite<CR>
    " show commit time
    nnoremap <Space>gb :Gblame<CR>
    nnoremap <Space>gl :let g:glog_cursor=line(".")<CR>:0Glog<CR>
    nnoremap <Space>gn :cnext<CR>
    nnoremap [q :cnext<CR>
    nnoremap <Space>gp :cprev<CR>
    nnoremap ]q :cprev<CR>
    nnoremap <Space>gN :cprev<CR>
"}}}


"{{{ YouCompleteMe Mappings
    nnoremap <Space>yb :YcmCompleter GoTo<CR>
    nnoremap <Space>yB :YcmCompleter GoToDeclaration<CR>
    nnoremap <Space>yd :YcmCompleter GetDoc<CR>
    nnoremap <Space>yf :YcmCompleter FixIt<CR>
    nnoremap <Space>yr :YcmRestartServer<CR>
    " Note here replace of FlagsForFile is due to use of clangd.
    nnoremap <Space>yg :![[ -e CMakeLists.txt ]] && rm .ycm_extra_conf.py<CR>:YcmGenerateConfig<CR>:!sed -i 's/FlagsForFile/Settings/g' .ycm_extra_conf.py<CR>
    " <c-e> :cancel completion
"}}}


"{{{ Mapping selecting Mappings
    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)
"}}}


"{{{ Insert mode completion
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    imap <c-x><c-l> <plug>(fzf-complete-line)

    " Advanced customization using autoload functions
    inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '14%'})
"}}}


" autocmd InsertLeave * :update

"{{{ directly use s to perform surround
    nmap s ys
"}}}


"{{{ Moving in insert mode

    inoremap <A-b> <c-left>
    inoremap <A-j> <c-o>o
    inoremap <A-k> <c-o>O
    inoremap <A-f> <c-right>
    inoremap <A-h> <c-left>
    inoremap <A-l> <c-right>
    
    inoremap <c-b> <left>
    inoremap <c-j> <down>
    inoremap <c-k> <up>
    inoremap <c-f> <right>

    inoremap <c-l> <right>
    
    inoremap <c-a> <c-o>^
    inoremap <c-e> <c-o>$
    
    inoremap <c-Space> <backspace>
    " inoremap <c-s-l> <delete>
    
    " inoremap <s-Enter> <c-o>o
    
    inoremap <c-d> <c-o>d
"}}}


"{{{ Easier moving in tabs and windows
    nnoremap <Space>tn gt
    nnoremap <Space>tN gT
    nnoremap <Space>tp gT
    nnoremap <A-n> :bn<CR>
    nnoremap <A-p> :bp<CR>
    nnoremap <A-J> <C-W>j
    nnoremap <A-K> <C-W>k
    nnoremap <A-L> <C-W>l
    nnoremap <A-H> <C-W>h
    " prevent conflict(type mistake) with tmux
    nnoremap <c-a> l
"}}}


"{{{ map for replacement
    nnoremap <A-H> :%s//gc<left><left><left>
    nnoremap <c-h> :%s//gc<left><left><left>
    xnoremap <c-h> :s//gc<left><left><left>
    cnoremap <c-h> <CR>:%s///gc<left><left><left>
"}}}

    
"{{{ don't copy when using c and C to change text
    nnoremap c "9c
    nnoremap C "9C
    nnoremap x "9x
    nnoremap X "9X
"}}}


"{{{ filetype specific keymap
    " to see more filetype, run command :
    " echo join(map(split(globpath(&rtp, 'ftplugin/*.vim'), '\n'), 'fnamemodify(v:val, ":t:r")'), "\n")

    " Run to another window if in tmux mode. Else run directly
    fun! Run_to_tmux_or_directly(command_str)
        if exists('$TMUX')
            call VimuxRunCommand(a:command_str)
            call feedkeys("<CR>")
        else
            exec "!" . a:command_str
        endif
    endf

    " jump to
    autocmd FileType c,cpp,python,java,javascript nnoremap <buffer> <c-b> :YcmCompleter GoTo<CR>

    " run current python buffer
    autocmd FileType matlab nnoremap <buffer> ,cc :w<CR>:!octave %<CR>
    autocmd FileType matlab nnoremap <buffer> ,cc :w<CR>:call Run_to_tmux_or_directly("octave " . expand("%:p"))<CR>
    autocmd FileType python nnoremap <buffer> ,cc :w<CR>:call Run_to_tmux_or_directly("python3 " . expand("%:p"))<CR>

    " run current javascript buffer
    autocmd FileType javascript nnoremap <buffer> ,cc :w<CR>:call Run_to_tmux_or_directly("node " . expand("%:p"))<CR>

    " run current c/cpp project
    autocmd FileType c,cpp nnoremap <buffer> ,cc :w<CR>:cd %:h<CR>:silent! Gcd<CR>:call VimuxCdWorkingDirectory()<CR>:call Run_to_tmux_or_directly("cmake_run ".expand('%:p')." --less-output")<CR>
    autocmd FileType c,cpp nnoremap <buffer> ,cm :w<CR>:cd %:h<CR>:silent! Gcd<CR>:call VimuxCdWorkingDirectory()<CR>:call Run_to_tmux_or_directly("cmake_run ".expand('%:p')." --make-only")<CR>
    " run c/cpp with mpi
    let g:mpi_processors_num=4
    com! -nargs=1 SetMpiProcessors let g:mpi_processors_num=<args>
    autocmd FileType c,cpp nnoremap <buffer> ,cp :w<CR>:cd %:h<CR>:silent! Gcd<CR>:call VimuxCdWorkingDirectory()<CR>:call Run_to_tmux_or_directly("cmake_run ".expand('%:p')." --less-output --make-only && mpirun -n ".g:mpi_processors_num." `make_find_executable`")<CR>

    autocmd BufRead,BufNewFile  CMakeLists.txt nnoremap <buffer> ,cc :w<CR>:cd %:h<CR>:silent! Gcd<CR>:call VimuxCdWorkingDirectory()<CR>:call Run_to_tmux_or_directly("cmake_run ".expand('%:t')." --less-output")<CR>
    autocmd BufRead,BufNewFile  CMakeLists.txt nnoremap <buffer> ,cm :w<CR>:cd %:h<CR>:silent! Gcd<CR>:call VimuxCdWorkingDirectory()<CR>:call Run_to_tmux_or_directly("cmake_run ".expand('%:t')." --make-only")<CR>
    " run c/cpp with mpi
    autocmd BufRead,BufNewFile  CMakeLists.txt nnoremap <buffer> ,cp :w<CR>:cd %:h<CR>:silent! Gcd<CR>:call VimuxCdWorkingDirectory()<CR>:call Run_to_tmux_or_directly("cmake_run ".expand('%:p')." --less-output --make-only && mpirun -n ".g:mpi_processors_num." `make_find_executable`")<CR>
    if has('nvim')
        " debug current python buffer
        autocmd FileType python nnoremap <buffer> ,cd :w<CR>:cd %:h<CR>:GdbStartPDB python -m pdb <c-r>%<CR>
        " debug current bash buffer
        autocmd FileType sh nnoremap <buffer> ,cd :w<CR>:cd %:h<CR>:GdbStartBashDB bashdb <c-r>%<CR>
        " debug current c/cpp project
        autocmd FileType c,cpp nnoremap <buffer> ,cd :w<CR>:cd %:h<CR>:silent! Gcd<CR>:GdbStart gdb -q -command="$HOME/Software/vim/gdb_init" `make_find_executable` <CR>
        " debug current c/cpp project
        autocmd BufRead,BufNewFile  CMakeLists.txt nnoremap <buffer> ,cd :w<CR>:cd %:h<CR>:silent! Gcd<CR>:GdbStart gdb -q -command="$HOME/Software/vim/gdb_init" `make_find_executable` <CR>
    else
        autocmd FileType c,cpp nnoremap <buffer> ,cd :set mouse=a<CR>:w<CR>:cd %:h<CR>:silent! Gcd<CR>:exec "Termdebug " . system('make_find_executable')<CR><c-w>j<c-w>j<c-w>L:sleep 1<CR><c-w>hstart<CR>source .gdb_breakpoints<CR>
        " autocmd FileType c,cpp nnoremap <buffer> ,cd :set mouse=a<CR>:w<CR>:cd %:h<CR>:silent! Gcd<CR>:exec "Termdebug -command=~/Software/vim/gdb_init " . system('make_find_executable')<CR><c-w>j<c-w>j<c-w>L:sleep 1<CR><c-w>h
    endif

    " latex mode save abbreviation
    autocmd FileType tex vnoremap <buffer> <m-s> "vy:call VisualSetAbbreviation()<CR>
    autocmd FileType tex nnoremap <buffer> <m-s> :call ShowAbbreviations()<CR>
    autocmd FileType tex inoremap <buffer> <m-s> <c-o>:call ShowAbbreviations()<CR>
    autocmd BufRead,BufNewFile */abbrev_defs.vim nnoremap <buffer> <m-s> :b#<CR>
    autocmd BufRead,BufNewFile */abbrev_defs.vim inoremap <buffer> <m-s> <c-o>:b#<CR>

    " latex mode jump to bibtex
    autocmd FileType tex nnoremap <buffer> <m-r> :e $HOME/Software/latex/bibtex/bib/ref.bib<CR>
    autocmd BufRead,BufNewFile $HOME/Software/latex/bibtex/bib/ref.bib nnoremap <buffer> <m-r> :b#<CR>
    autocmd FileType tex LoadAbbreviations
    " latex mode specified mappings
    autocmd FileType tex call DefLatexMappings()
    " start vim server for latex preview
    autocmd FileType tex call StartLatexServer()
    " enable auto save for real-time preview
    autocmd FileType tex autocmd TextChangedI <buffer> call LatexAutoSave(5)
    autocmd FileType tex autocmd CursorHoldI,CursorHold <buffer> silent update
    autocmd FileType tex autocmd TextChanged <buffer> call LatexAutoSave(0)

    " keymap for c/c++ file type
    autocmd FileType c,cpp imap <buffer> <a-;> <c-e>;<CR>


    " translation auto repl
    autocmd BufRead,BufNewFile $HOME/Software/baiduTranslate/software/toBeTranslate.txt autocmd TextChangedI <buffer> call TranslateCount(5)
    autocmd BufRead,BufNewFile $HOME/Software/baiduTranslate/software/toBeTranslate.txt autocmd TextChanged <buffer> call TranslateCount(0)
    autocmd BufRead,BufNewFile $HOME/Software/baiduTranslate/software/toBeTranslate.txt autocmd CursorHoldI,CursorHold <buffer> call TranslateCount(0)

    " keymap for open_file_help file(e.g. Used to OpenTodoFile)
    autocmd BufRead,BufNewFile  $HOME/Software/vim/open_file_help.sh map <buffer> <esc> :bd!<CR>
    autocmd BufRead,BufNewFile  $HOME/Software/vim/open_file_help.sh imap <buffer> <c-c> <c-o>:bd!<CR>
    autocmd BufRead,BufNewFile  $HOME/Software/vim/open_file_help.sh imap <buffer> <c-h> <c-w><c-w>
    autocmd BufRead,BufNewFile  $HOME/Software/vim/open_file_help.sh inoremap <buffer> <CR> <c-o>:stopinsert<CR>:let mycurf=expand("<cfile>")<CR>:bd!<CR>:execute("e ".mycurf)<CR>
    
    " freefem++ file type
    au BufNewFile,BufRead *.edp setf edp
    au BufNewFile,BufRead *.idp setf edp
    au FileType  edp nnoremap ,cc :w<CR>:call Run_to_tmux_or_directly("cd ".expand('%:p:h')." && FreeFem++ ".expand('%:p'))<CR>
    " load completion.edp for better completion
    au FileType  edp call s:LoadFreefemCompletion()

    " fugitive glog: auto jump to the same line
    au! BufLeave  fugitive://*  let g:glog_cursor=line(".")
    " au! BufEnter  fugitive://*  exec g:glog_cursor 
    au! BufEnter  fugitive://*  exec "if exists('g:glog_cursor')\n exec g:glog_cursor\n endif\n"

    " command-line window enter insert mode automatically
    " after :/?, type <c-f> to edit
	au CmdwinEnter [:/?]  startinsert

    " Set filetype to be same with previous file when searching because
    " autocomplete will search all buffer with same filetype 
    au BufEnter * let g:previous_buf_filetype=&filetype
    au CmdwinEnter [/?]  exec "set filetype=" . g:previous_buf_filetype

    function! s:ChangeFileTypeIfReplacing()
        if stridx(getline('.'),"s/") >= 0
            exec "set filetype=" . g:previous_buf_filetype
        endif
    endfunction


    " Set filetype to be the same with previous file when replacing in
    " command-line mode
    au CmdwinEnter [:] call s:ChangeFileTypeIfReplacing()

    " execute the command under the cursor and then have the command-line window open again
	autocmd CmdwinEnter * map <buffer> <F5> <CR>q:

    " Debug mode auto command
	" au CmdwinEnter [>] do something

    " enter repl for tmux window
    function! VimEnterExec()
        if !exists("b:VimEterExecFlag")
            let b:VimEterExecFlag=0
        endif

        if b:VimEterExecFlag
            iunmap <buffer> <enter>
            vunmap <buffer> <enter>
            nunmap <buffer> <enter>
            let b:VimEterExecFlag=0
        else
            inoremap <buffer> <enter> <c-o>$<c-o>:exec getline(".")<CR><CR>
            vnoremap <buffer> <enter> "vy :@v<CR>
            nnoremap <buffer> <enter> :exec getline(".")<CR>j

            let b:VimEterExecFlag=1
        endif
    endfunction

    autocmd FileType vim nnoremap <space>vp :call VimEnterExec()<CR>
"}}}


"""""""""""""""""""""""""""""""""""""
" Map from spacemacs
"""""""""""""""""""""""""""""""""""""
" nunmap <Space>
nnoremap <Space><Space> :<c-f>
nnoremap <silent> <Space>wh :call CloseMaximize()<CR><C-w>h
nnoremap <silent> <Space>wj :call CloseMaximize()<CR><C-w>j
nnoremap <silent> <Space>wk :call CloseMaximize()<CR><C-w>k
nnoremap <silent> <Space>wl :call CloseMaximize()<CR><C-w>l
nnoremap <Space>wH :call CloseMaximize()<CR><C-w>H
nnoremap <Space>wJ :call CloseMaximize()<CR><C-w>J
nnoremap <Space>wK :call CloseMaximize()<CR><C-w>K
nnoremap <Space>wL :call CloseMaximize()<CR><C-w>L
nnoremap <Space>w/ :call CloseMaximize()<CR>:vs<CR>
" map <ESC> to exit insert mode in shell buffer
" tnoremap <ESC>   <C-\><C-n>
nnoremap <Space>w- :call CloseMaximize()<CR>:sp<CR>
nnoremap <Space>ww :call CloseMaximize()<CR><C-w>w
nnoremap <Space>w= :call CloseMaximize()<CR><C-w>=
nnoremap <Space>wd :call CloseMaximize()<CR>:close<CR>
nnoremap <Space>wx :call CloseMaximize()<CR>:bp<cr>:silent! exec "bd #"<CR>:close<CR>
nnoremap <Space>wo :call CloseMaximize()<CR><C-w><C-o>
nnoremap <c-down>  2<C-w>-
nnoremap <c-up>    2<C-w>+
nnoremap <c-left>  2<C-w><
nnoremap <c-right> 2<C-w>>
nnoremap <Space>1  :call CloseMaximize()<CR>1<C-w><C-w>
nnoremap <Space>2  :call CloseMaximize()<CR>2<C-w><C-w>
nnoremap <Space>3  :call CloseMaximize()<CR>3<C-w><C-w>
nnoremap <Space>4  :call CloseMaximize()<CR>4<C-w><C-w>
nnoremap <Space>5  :call CloseMaximize()<CR>5<C-w><C-w>
nnoremap <Space>6  :call CloseMaximize()<CR>6<C-w><C-w>
nnoremap <Space>7  :call CloseMaximize()<CR>7<C-w><C-w>
nnoremap <Space>8  :call CloseMaximize()<CR>8<C-w><C-w>
nnoremap <Space>9  :call CloseMaximize()<CR>9<C-w><C-w>
" insert dividing line
nnoremap <Space>id :r !echo "-----------------------------------------------------------------------"<CR>:TComment<CR>5l

" folding
nnoremap <Space>z+ zR
nnoremap <Space>z- zM

nnoremap <Space>fr :FzfMrf!<CR>
" goto
" tags (symbols) in current file finder mapping
nnoremap ,gt :CtrlPBufTag<CR>
" tags (symbols) in all files finder mapping
nnoremap ,gT :CtrlPBufTagAll<CR>
" recent changes in all buffers
nnoremap ,gC :CtrlPChangeAll<CR>
" recent changes in current buffer
nnoremap ,gc :SearchChanges!<CR>
nnoremap <A-c> :SearchChanges!<CR>
" recent jumps in current buffer
nnoremap ,gj :JumpsResults!<CR>

nnoremap <c-c><c-o> gf
" nnoremap <Space>fo :!nautilus "<cfile>"& <CR>
" open file under the cursor with default system software
nnoremap <Space>fo :!cd %:p:h && xdg-open "<cfile>" & <CR>
" open the folder containing current file
nnoremap <Space>fd :!nautilus %:p:h &<CR>
" open the terminal with current file path as working directory
nnoremap <Space>ft :silent! !gnome-terminal --working-directory=%:p:h &<CR>
if exists("$TERMINOLOGY")
    nnoremap <Space>ft :silent! !terminology -d %:p:h &<CR>
endif
" nnoremap <Space>ff :CtrlP %<CR>
nnoremap <Space>ss :CtrlPLine %<CR>
nnoremap <Space><Tab> :b#<CR>
nnoremap ]e        :move +1<CR>
nnoremap [e        :move -2<CR>
" nnoremap <Space><Space> :
nnoremap <Space>fvd :OpenVimrcDotFile<CR>
execute "nnoremap <Space>fvR :source " . b:dot_file_path . "<CR>"
nnoremap <Space>mcc :w<CR>:!python %<CR>
nnoremap <Space>/  :Ag!<CR>
vnoremap <Space>/  "vy:exec "Ag!" . escape(@v,'/\()*+?[]$^<bar>')<CR>
nnoremap <c-f>  :w<CR>:AgCurrentFile!<CR>
" map * to search selection
vnoremap * "vy/\V<C-R>=escape(@v,'/\')<CR><CR>
nnoremap <Space>bd :bn<CR>:bd#<CR>
nnoremap <Space>bm :messages<CR>
nnoremap <Space>bn :bn<CR>
nnoremap ]b :bn<CR>
nnoremap <Space>bp :bp<CR>
nnoremap [b :bp<CR>
" nnoremap <Space>bb :CtrlPBuffer<CR>
nnoremap <Space>bb :FzfBuffers!<CR>
nnoremap <Space>bs :Scratch<CR>
nnoremap <Space>bx :call CloseMaximize()<CR>:bp<cr>:silent! exec "bd #"<CR>:close<CR>
nnoremap <Space>b1 :bfirst<CR>
nnoremap <Space>b2 :call g:GotoNthBuffer("1")<CR>
nnoremap <Space>b3 :call g:GotoNthBuffer("2")<CR>
nnoremap <Space>b4 :call g:GotoNthBuffer("3")<CR>
nnoremap <Space>b5 :call g:GotoNthBuffer("4")<CR>
nnoremap <Space>b6 :call g:GotoNthBuffer("5")<CR>
nnoremap <Space>b7 :call g:GotoNthBuffer("6")<CR>
nnoremap <Space>b8 :call g:GotoNthBuffer("7")<CR>
nnoremap <Space>b9 :call g:GotoNthBuffer("8")<CR>

nnoremap <Space>tn gt
nnoremap <Space>tN gT
nnoremap <Space>tp gT

" save layout
nnoremap <Space>ls :call SaveLayout(0)<CR>
nnoremap <Space>lS :call SaveLayout(1)<CR>
nnoremap <Space>ll :call LoadLayout(0)<CR>
nnoremap <Space>lL :call LoadLayout(1)<CR>

nnoremap <Space>qq :qa<CR>
nnoremap <Space>hd :help 
nnoremap <Space>cd :cd %:h<CR>:silent! Gcd<CR>
nnoremap <Space>tw :ToggleWrap<CR>
nmap <space>aa :FindActions<CR>
nmap <space>ag :!gedit %<CR>
nmap <space>au :UndotreeToggle<CR>
if has('nvim')
    nnoremap <space>as :terminal<CR>
else
    nnoremap <space>as :vertical terminal ++curwin<CR>
endif
" tnoremap <C-w> <C-\><C-n>
" tnoremap <C-w>h <C-\><C-n><C-w>h
" tnoremap <C-w>j <C-\><C-n><C-w>j
" tnoremap <C-w>k <C-\><C-n><C-w>k
" tnoremap <C-w>l <C-\><C-n><C-w>l
map <Space>v <Plug>(expand_region_expand)
nmap <c-c><c-o> :call OpenUrlUnderCursor()<CR>

" *** functions for spacemacs maps *************
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

let g:custom_layout_path="~/Software/vim/session"
function! SaveLayout(toInputName)
    cd %:h
    silent! Gcd
    if a:toInputName
        call inputsave()
        let s:input_layout_name=input('Please input layout(session) name: ')
        call inputrestore()
        let s:layout_path=g:custom_layout_path . "/" . s:input_layout_name . ".vim"
    else
        let s:layout_path=g:custom_layout_path . "/" . system("printf `basename " . getcwd() . "`.vim")
    endif
    exec "mksession! " . s:layout_path
endfunction

function! LoadLayout(toInputName)
    if a:toInputName
        12sp $HOME/Software/vim/open_file_help.sh
        exec "normal! \<c-w>J"
        exec "r!echo " . g:custom_layout_path
        exec "normal!k\"pdd"
        startinsert!

        iunmap <buffer> <enter>
        inoremap <buffer> <enter> <c-o>:stopinsert<CR>:let mycurf=expand("<cfile>")<CR>:bd!<CR>:execute("source ".mycurf)<CR>
    else
        let s:layout_path=g:custom_layout_path . "/" . system("printf `basename " . getcwd() . "`.vim")
        exec "source " . s:layout_path

    endif
endfunction

function s:Toggle_Wrap()
    if &wrap
        windo set wrap!
    else
        windo set wrap
    endif

endfunction
" com!ToggleWrap windo set wrap
com!ToggleWrap call s:Toggle_Wrap()

"""""""""""""""""""""""""""""""""""""
" Configuration Section
"""""""""""""""""""""""""""""""""""""

" turn off key timeout
if has('nvim')
    set notimeout
else
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

endif



" smart case for / search
set ignorecase
set smartcase

" highlight all search matches
:set hlsearch

" highlight the next match while you're still typing out your search pattern
:set hlsearch incsearch

" set more visual hints in command-line mode
set wildmenu

" maximum number of lines saved for each register would be 50, the maximum size of saved items is 10 KB and the effect of 'hlsearch' is disabled when loading the viminfo file.
set viminfo='500,<50,s10,h

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

" {{{ vimdebug
    " let g:termdebug_wide = 163
" }}}



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
    " in ~/.vim/plugged/YouCompleteMe for vim
    " in ~/.nvim/plugged/YouCompleteMe for nvim
    " python3 install.py --clang-completer  # for nvim
    " python3 install.py --clangd-completer  # for vim

    " To generate .ycm_extra_conf.py according to CMakeList.txt, run:
    " :YcmGenerateConfig

    let g:ycm_always_populate_location_list = 1
    " open keyword completion
    let g:ycm_seed_identifiers_with_syntax=1
    " let g:ycm_python_binary_path = 'python3'
    "blacklist for youcompleteme
    let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'gitcommit' : 1,
            \}
    let g:ycm_autoclose_preview_window_after_completion = 1

    " Let clangd fully control code completion
    let g:ycm_clangd_uses_ycmd_caching = 0
    " Use installed clangd, not YCM-bundled clangd which doesn't get updates.
    let g:ycm_clangd_binary_path = exepath("clangd")

    
    let g:ycm_disable_signature_help = 0
    let g:ycm_auto_trigger = 1

    " python completion settings
    " let g:ycm_python_interpreter_path = '/usr/bin/python'
    " let g:ycm_python_sys_path = []
    " let g:ycm_extra_conf_vim_data = [
      " \  'g:ycm_python_interpreter_path',
      " \  'g:ycm_python_sys_path'
      " \]
    let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
" }}}



" julia-vim {{{
    let g:julia#doc#juliapath=$HOME.'/Software/julia/julia-1.3.1/bin/julia'
" }}}



" Fzf {{{ 
    " This is the default extra key bindings
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-f': 'read @/',
      \}

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
      \   'cat $HOME/Software/vim/vim_tip/find_actions '.shellescape(<q-args>), 1)

    " preview and open project file with fzf
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


    function! Changes_results(query,fullscreen)
        redir! > ~/Software/vim/odd_txt_for_vim.txt
        silent changes
        redir end
        exec "silent !~/Software/vim/format_help/format_for_changes " . expand("%")

        call fzf#vim#grep(
        \ 'cat ~/Software/vim/odd_txt_for_vim.txt ' , 0,fzf#vim#with_preview({'options': '--layout=reverse'},'up:60%'), a:fullscreen)
    endfunction
    command! -nargs=* -bang SearchChanges call Changes_results(<q-args>, <bang>0)

    function! Jumps_results(query,fullscreen)
        redir! > ~/Software/vim/odd_txt_for_vim.txt
        silent jumps
        redir end
        exec "silent !~/Software/vim/format_help/format_for_jumps " . expand("%")

        call fzf#vim#grep(
        \ 'cat ~/Software/vim/odd_txt_for_vim.txt ' , 0,fzf#vim#with_preview({'options': '--layout=reverse'},'up:60%'), a:fullscreen)
    endfunction
    command! -nargs=* -bang JumpsResults call Jumps_results(<q-args>, <bang>0)

    command! -bang -nargs=* FzfMrf call fzf#vim#history(fzf#vim#with_preview({'options': '--layout=reverse'},<bang>0?'up:65%':'right:50%'),<bang>0)

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

    function! Fzf_buffers(query,fullscreen)
      call fzf#vim#grep(
      \ "echo '" . s:buffer_list() . "'" , 0,fzf#vim#with_preview({'options': '--layout=reverse'},'up:65%'), a:fullscreen)
    endfunction
    command! -nargs=* -bang FzfBuffers call Fzf_buffers(<q-args>, <bang>0)
" }}}



" easymotion {{{
    map <Leader> <Plug>(easymotion-prefix)
" }}}



" undotree {{{
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif
" }}}



" TCommentO
    let g:tcomment_opleader1="<space>;"
    nnoremap <space>;;  :TComment<CR>
" }}}



" Scratch {{{
    let g:scratch_persistence_file = "$HOME/Software/vim/Scratch"
    let g:scratch_no_mappings = 1
    let g:scratch_height = 15
    let g:scratch_autohide = 0
" }}}



" CtrlP {{{
    let g:ctrlp_extensions = [ 'line' ]
    " nnoremap <c-f> :CtrlPLine %<CR>
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
" }}}



" {{{ neomake
    call neomake#configure#automake('nrwi', 500)
    " disable lint/syntax check
    let g:neomake_python_enabled_makers = []
    let g:neomake_c_enabled_makers = []
    let g:neomake_cpp_enabled_makers = []
    let g:neomake_javascript_enabled_makers = []
" }}}



" {{{ vim-youdao-translater, baidu-translate from command line
    function! Translate()
        " let g:abcd=substitute(@v,"\'","\\'","g")
        let s:translate_string=substitute(@v,"\'","","g")
        let s:translate_string=substitute(s:translate_string,"\n",'    ',"g")
        exec "!translate '" . s:translate_string . "'"
        " exec "!translate '" . @v . "'"
    endfunction

    " vnoremap <silent> <c-h>c :<C-u>Ydv<CR>
    nnoremap <silent> <Space>hc :<C-u>Ydc<CR>
    vnoremap <silent> <Space>hc "vy :call Translate()<CR>
    noremap <Space>htc :<C-u>Yde<CR>

    function! s:TranslateRepl()
        if &modified
            silent write
            silent! exec '!translate "$(< $HOME/Software/baiduTranslate/software/toBeTranslate.txt)" > /tmp/oddtranslate && cat /tmp/oddtranslate > $HOME/Software/baiduTranslate/software/translated.txt'
        endif
    endfunction
    let g:translate_count=0
    " call s:TranslateRepl() if this method is called translateCount times
    " This method is called with the help of autocmd
    " translation output will be redirect to
    " $HOME/Software/baiduTranslate/software/translated.txt
    " Use watch -t -n 0.3 cat translated.txt to watch
    function! TranslateCount(translateCount)
        if g:translate_count >= a:translateCount
            let g:translate_count=0
            call s:TranslateRepl()
        else
            let g:translate_count=g:translate_count + 1
        endif
    endfunction
" }}}


" {{{ flake8
    " let g:flake8_show_in_gutter=1  " show signs in the gutter
    " let g:flake8_show_in_file=1  " show marks in the file
" }}}



" {{{ snippets
    " snippets of vim-snippets are in folders under:
    " /home/ban/.vim/plugged/vim-snippets/UltiSnips
    " /home/ban/.vim/plugged/vim-snippets/snippets
    "
    " custom snippets are in folders under:
    " /home/ban/.vim/UltiSnips
    " Use :UltiSnipsEdit to edit custom snippet with current file type.
    "
    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<c-v>"
    let g:UltiSnipsJumpForwardTrigger="<m-n>"
    let g:UltiSnipsJumpBackwardTrigger="<m-p>"  " disable this due to conflict with latex c-b bold font

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"

" }}}



" {{{ vim-autoformat
    let g:formatdef_clangformat ="'clang-format -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" -style=\"{ AlignTrailingComments: true, '.(&textwidth ? 'ColumnLimit: '.&textwidth.', ' : '').(&expandtab ? 'UseTab: Never, IndentWidth: '.shiftwidth() : 'UseTab: Always').'}\"'"
    nnoremap ,f :Autoformat<CR>
    xnoremap ,f :Autoformat<CR>
" }}}



" {{{ neoformat
    " nnoremap ,f :Neoformat<CR>
    " xnoremap ,f :Neoformat<CR>
    
    " following command contains bug: after command, ,cc will be mapped to cpp
    " run command

" }}}



" {{{ vimux
    " when origin filetype==""
    let g:VimuxReplDefaultFiletype='python'
    let g:VimuxOrientation = "h"
    let g:VimuxHeight = "50"

    nmap <space>: :call VimuxPromptCommand()<CR><c-f>:exec "set filetype=" . g:previous_buf_filetype<CR>i
    nmap <space>v: :call VimuxPromptCommand()<CR>
    nmap <space>vo :call VimuxOpenRunner()<CR>
    nmap <space>vl :call VimuxRunLastCommand()<CR>
    nmap <space>vc :call VimuxCloseRunner()<CR>
    nmap <space>vr :call VimuxRunCommand("!!\n")<CR>
    function! VimuxSlimeVisual()
        " delete empty line (for python)
        let s:vimux_slime_delete_blank_line=substitute(@v,'\n\n\+','\n','g')
        " add empty line to jump out of block (for python)
        let s:vimux_slime_delete_blank_line=substitute(s:vimux_slime_delete_blank_line,'\(\n\s[^\n]\+\n\)\(\S\)','\1\n\2','g')

        call VimuxRunCommand(s:vimux_slime_delete_blank_line)
    endfunction
    vmap <space>vs "vy :call VimuxSlimeVisual()<CR>
    function! VimuxSlimeNormal()
        call VimuxRunCommand(getline("."))
    endfunction
    nmap <space>vs :call VimuxSlimeNormal()<CR>
    " toggle using vim for repl in another pane
    function! VimuxForRepl()
        if !exists("b:VimuxForReplFlag")
            let b:VimuxForReplFlag=0
        endif

        if b:VimuxForReplFlag
            iunmap <buffer> <enter>
            vunmap <buffer> <enter>
            nunmap <buffer> <enter>
            let b:VimuxForReplFlag=0
        else
            inoremap <buffer> <enter> <c-o>$<c-o>:call VimuxSlimeNormal()<CR><enter>
            vnoremap <buffer> <enter> "vy :call VimuxSlimeVisual()<CR>
            nnoremap <buffer> <enter> :call VimuxSlimeNormal()<CR>j
            VimuxRunCommand("cd " . expand("%:p:h"))

            let b:VimuxForReplFlag=1

            if(&filetype=='')
                exec "set filetype=" . g:VimuxReplDefaultFiletype
            endif

            " set initial code for specific filetype
            if(&filetype=='python')
                VimuxRunCommand("python3")
            endif
            if(&filetype=='javascript')
                VimuxRunCommand("node")
            endif
            if(&filetype=='matlab')
                VimuxRunCommand("octave --no-window-system")
            endif
            if(&filetype=='julia')
                VimuxRunCommand("julia")
            endif

            " if(&filetype=='vim') see function VimEnterExec
        endif
    endfunction
    nmap <space>vp :call VimuxForRepl()<CR>

    function!VimuxCdWorkingDirectory()
        call VimuxRunCommand(" cd ".expand('%:p:h'))
        call VimuxRunCommand(" cd `git rev-parse --show-toplevel 2>/dev/null || echo .`")
    endfunction
" }}}



" {{{ vim-tmux-navigator
    let g:tmux_navigator_no_mappings = 1

    nnoremap <silent> <A-h> :call CloseMaximize()<CR>:TmuxNavigateLeft<CR>
    nnoremap <silent> <A-j> :call CloseMaximize()<CR>:TmuxNavigateDown<CR>
    nnoremap <silent> <A-k> :call CloseMaximize()<CR>:TmuxNavigateUp<CR>
    nnoremap <silent> <A-l> :call CloseMaximize()<CR>:TmuxNavigateRight<CR>
    nnoremap <silent> <A-p> :call CloseMaximize()<CR>:TmuxNavigatePrevious<CR>
    " Maximize considering all vim panes and tmux panes
    function! ToggleMaximizeTmux()
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
    function!CloseMaximize()
        if g:isToggledVertically || g:isToggledHorizontally
            silent! call ToggleMaximize()
        endif

    endfunction
    nnoremap <silent> <A-z> :call ToggleMaximizeTmux()<CR>
    inoremap <silent> <A-z> <c-o>:call ToggleMaximizeTmux()<CR>
" }}}

" {{{ vim-gdb
    if has('nvim')
        nnoremap ,qq :GdbSaveBreakpoints<CR>:sleep 1<CR>:GdbDebugStop<CR>
        tnoremap <c-b> save breakpoints .gdb_breakpoints<CR>q<CR>
    else
        nnoremap ,qq :call TermDebugSendCommand('save breakpoints .gdb_breakpoints')<CR>:call TermDebugSendCommand('q')<CR>
        tnoremap <c-b> save breakpoints .gdb_breakpoints<CR>q<CR>
    endif
" }}}



" {{{ abbreviation (This is a functionality of vim rather than a plugin
    function!PrintIt(to_print)
        return a:to_print
    endfunction
    function!VisualSetAbbreviation ()
        cd %:h
        " iabbrev will set abbreviation for insert mode
        let l:abb_name = input('Please input abbreviation: ')
        exec "iabbrev " . l:abb_name . " " . @v
        silent call SaveAbbr(l:abb_name)
    endfunction
    vnoremap <Space>va "vy:call VisualSetAbbreviation()<CR>

    function! SaveAbbr(abb_name)
        redir >> ./abbrev_defs.vim
        "foo.txt is the file in which you wish to add your abbreviations. For me, it
        "is ~/.vim/ftplugin/tex.vim
        echo "iabbrev " . a:abb_name . " " . @v
        redir END
    endfunction

    function! LoadAbbr()
        cd %:h
        if filereadable("./abbrev_defs.vim")
            source ./abbrev_defs.vim
        else
            echo "there is no abbrev_defs.vim file in current directory"
        endif
    endfunction
    com! LoadAbbreviations call LoadAbbr()

    function! ShowAbbreviations()
        e ./abbrev_defs.vim
    endfunction

    "Replace S-F8 by any other shortcut you wish
" }}}



" {{{ vimtex
    let g:vimtex_view_general_viewer = 'zathura'
    let g:vimtex_view_method='zathura'
    let g:vimtex_compiler_callback_hooks = ['ZathuraHook']
    let g:vimtex_fold_enabled=1
    let g:vimtex_quickfix_open_on_warning=0
    let g:vimtex_quickfix_mode=0

    " Note: The Zathura and MuPDF viewers, if used, add a hook to this list in
    "       order to store the viewer X window ID in order to prevent multiple
    "       viewer windows.
    function! ZathuraHook(status)
      echom a:status
    endfunction

    let g:vimtex_mappings_enabled = 0
    let g:vimtex_latexmk_options='-pdf -pdflatex="xelatex -synctex=1 \%S \%O" -verbose -file-line-error -interaction=nonstopmode'
    " let g:vimtex_compiler_progname=v:progname
    function! DefLatexMappings()
        nmap <buffer> ,i <plug>(vimtex-info)
        nmap <buffer> ,b <plug>(vimtex-compile)
        nmap <buffer> ,c <plug>(vimtex-clean)
        nmap <buffer> ,v <plug>(vimtex-view)
        inoremap <buffer> <m-v> <c-o>:VimtexView<CR>
        nmap <buffer> ,r <plug>(vimtex-reverse-search)
        nmap <buffer> ,e <plug>(vimtex-errors)
        inoremap <buffer> <c-j> _{}<left>
        inoremap <buffer> <c-k> ^{}<left>
        inoremap <buffer> <c-o> $$<left>
        inoremap <buffer> <c-b> \textbf{}<left>
    endfunction
    function!StartLatexServer()
        if empty(v:servername) && exists('*remote_startserver')
          call remote_startserver('VIM')
        endif
    endfunction

    let g:latex_auto_save_count=0
    function!LatexAutoSave(save_count)
        if g:latex_auto_save_count >= a:save_count
            let g:latex_auto_save_count=0
            silent write
        else
            let g:latex_auto_save_count=g:latex_auto_save_count + 1
        endif
    endfunction

" }}}



" {{{ freefem++
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
" }}}


" {{{ ranger (Interactive with ranger - a file manager installed by sudo apt
" install ranger)

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
" }}}
