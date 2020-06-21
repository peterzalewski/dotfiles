" vim: set foldmethod=marker foldlevel=0 nomodeline:
" ############################################################################
" Description: set up vim, not too much, mostly small things
" Author: Peter Zalewski <peter@zalewski.com>
" Source: https://github.com/peterzalewski/dotfiles/blob/master/vimrc
"
" Manage plugins with vim-plug: https://github.com/junegunn/vim-plug
" ############################################################################

" Preamble {{{

" Disable vi compatibility to enable full vim functionality
set nocompatible

" Support for syntax highlighting is disabled by default
syntax enable

" Enable filetype detection, plugin support, and autoindent 
" These plugins come standard but disabled
filetype plugin indent on

"  }}}
"  Plugins {{{

call plug#begin()

" Oceanic-Next color scheme
Plug 'mhartington/oceanic-next'

" Comment lines and blocks, sensitive to file type
Plug 'tomtom/tcomment_vim'

" Lightweight status line
Plug 'itchyny/lightline.vim'

" Better JavaScript syntax
Plug 'pangloss/vim-javascript'

" Close the current buffer but not the window
Plug 'mhinz/vim-sayonara'

" Manipulate quoting and parenthizing characters
Plug 'tpope/vim-surround'

" Navigate between tmux panes and vim windows
Plug 'christoomey/vim-tmux-navigator'

" Asynchronously lint and syntax check buffers
Plug 'w0rp/ale'

" Syntax for Jinja2
Plug 'Glench/Vim-Jinja2-Syntax'

" Align text by characters and more complex expressions
Plug 'junegunn/vim-easy-align'

" Syntax for JSX
Plug 'mxw/vim-jsx'

" Use FZF for searching files, buffers, etc.
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Repeat vim-surround commands with .
Plug 'tpope/vim-repeat'

" Smartly manage tags
Plug 'peterzalewski/vim-gutentags', { 'branch': 'language_specific', 'do': 'mkdir -p ${HOME}/.ctags' }

" Promote productivity with distration-free mode
Plug 'junegunn/goyo.vim'

" Highlight current (or adjacent) blocks of text and dim everything else
Plug 'junegunn/limelight.vim'

" Draw arrows and boxes in visual block mode
Plug 'peterzalewski/vim-boxdraw'

" Syntax for .tmux.conf
Plug 'tmux-plugins/vim-tmux'

" Syntax for my todo.txt
Plug 'peterzalewski/vim-todo'

" Syntax for Apache Thrift definitions
Plug 'solarnz/thrift.vim'

" Use ripgrep (rg) for searching in files
Plug 'jremmen/vim-ripgrep'

call plug#end()

" }}}
" Appearance {{{

if has('termguicolors')
    set termguicolors               " Enable 24-bit color
else
    set t_Co  = 256
endif

if !has('nvim')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" itchyny/lightline.vim
let g:lightline = {
    \ 'colorscheme': 'oceanicnext',
    \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ]
    \ }
\ }

" Use this color scheme
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

" Use italic for comments
highlight Comment cterm=italic
highlight SpecialComment cterm=italic

" Highlight line number in magenta
highlight CursorLineNr guifg='#C594C5' ctermfg=176 guibg=NONE ctermbg=NONE

" Highlight the paren under the cursor, not the matching paren
hi MatchParen ctermfg=208 ctermbg=233 cterm=bold

" }}}
" Built-in options {{{

set autoindent                  " Copy indent from current line when starting new line
set autoread                    " Re-read files changed outside of vim
set backspace=eol,indent,start  " Backspace over EOL, indents, and start of line in insert mode
set clipboard=unnamed           " Yank to system clipboard
set completefunc=emoji#complete " Auto-complete Emoji!
set encoding=utf8               " Default to UTF-8 everywhere, including registers
set expandtab                   " Convert tabs to spaces in insert mode
set fileformats=unix,mac,dos    " Set EOL preferences and default to Unix line endings
set fillchars=vert:\│           " Handsome vertical split character
set foldlevelstart=20           " Edit files with first 20 levels of folds open
set foldmethod=indent           " Fold lines with equal indent levels
set formatoptions=qcj           " Auto-wrap comments, allow q in comments, remove comment leaders on join
set gdefault                    " Substitutes are global on the current line by default
set hidden                      " Abandoning hides buffers rather than unloads them
set hlsearch                    " Highlight search results
set ignorecase                  " Ignore case in search patterns
set incsearch                   " Show first match as you type pattern
set laststatus=2                " Additional status line
set lazyredraw                  " Do not redraw unnecessarily
set modelines=2                 " Use settings from comments in files
set nobackup                    " Do not keep backups after overwriting files
set nojoinspaces                " Only insert one space when joining lines
set nostartofline               " Don't always jump to start of line
set noswapfile                  " Do not create swap files
set nowritebackup               " Do not create backups when writing files
set number                      " Show absolute line number on current line
set pastetoggle=<F12>           " Toggle paste in insert and normal mode with F12
set relativenumber              " Line numbers are relative to current line
set ruler                       " Display row and column in file
set scrolloff=2                 " 2 lines of context for jumping to search results
set shiftround                  " Round indents to multiple of 'shiftwidth'
set shiftwidth=2                " Indent by 2 spaces
set shortmess+=I                " Do not display the vim intro message on start
set showcmd                     " Show last command below status line
set showmatch                   " Briefly jump to matching bracket after inserting one
set showmode                    " Indicates if in insert mode
set smartcase                   " Default to case-insensitive search pattern until typing a capital letter
set smarttab                    " Use 'shiftwidth' spaces when typing tab at beginning of line
set softtabstop=2               " Use 2 spaces when typing tab anywhere
set splitbelow                  " Default to opening new horizontal split BELOW current one
set splitright                  " Default to opening new vertical split to RIGHT of current one
set tabstop=2                   " Display tabs with 2 spaces
set ttyfast                     " Yes, this is a fast terminal connection
set virtualedit+=block          " Let me move past the last character on the line in visual mode
set visualbell                  " Flash screen instead of annoying me
set wildignore+=.git            " Ignore .git when expanding wildcards and completing filenames
set wildignore+=node_modules    " Ignore node_modules when expanding wildcards and completing filenames
set wildmenu                    " Tab-completion for commands
set wildmode=list:full,longest  " List possible commands by length first

" }}}
" Plugin-specific settings {{{

" ludovicchabant/vim-gutentags
" If the filetype is known, append it to the tag file name
" to group tags by language.
function! PeteZalewskiTagFilePerFiletype(path)
    if strlen(&l:filetype) ># 0
        let b:gutentags_ctags_tagfile = &l:filetype . '.tags'
        return 1
    endif
    return 0
endfunction

let g:gutentags_enabled                   = 1
let g:gutentags_add_default_project_roots = 1
let g:gutentags_cache_dir                 = glob("~/.ctags")
let g:gutentags_ctags_language_specific   = 1
let g:gutentags_file_list_command         = 'rg --files'
let g:gutentags_init_user_func            = 'PeteZalewskiTagFilePerFiletype'

" jremmen/vim-ripgrep
let g:rg_derive_root = 1

" junegunn/fzf.vm
let g:fzf_layout = { 'down': '8' }

" junegun/goyo.vim
" 2018-09-08 TODO: set Goyo width to &l:textwidth (if set)
function! s:goyo_enter()
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    Limelight
endfunction
function! s:goyo_leave()
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    Limelight!
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:goyo_width = 107

" pangloss/vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow  = 1

" w0rp/ale
let g:ale_sign_column_always   = 1
let g:ale_echo_msg_error_str   = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format      = '[%severity%/%linter%] %s'

" }}}
" Abbreviations {{{

" Remind myself to do something
iabbrev <expr> \t printf(&l:commentstring . " TODO:", strftime(" %Y-%m-%d"))

" }}}
" Mappings {{{

" Edit the previously edited file
nnoremap <C-e> :e#<CR>

" Append the modifier for very magic mode, to get Perl-like regex
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Leader commands
let mapleader=","

" Remove search highlight
nnoremap <leader><space> :noh<cr>

" Open a vertical split
nnoremap <leader>v <C-w>v<C-w>l

" Open a horizontal split
nnoremap <leader>h <C-w>s<C-w>j

" Close the buffer but keep the window open - mhinz/vim-sayonara
nnoremap <leader>q :Sayonara!<cr>

" Search files with FZF - junegunn/fzf.vim
nnoremap <leader>t :Files<cr>

" Search buffers with FZF - junegunn/fzf.vim
nnoremap <leader>b :Buffers<cr>

" Search modified git files with FZF - junegunn/fzf.vim
nnoremap <leader>g :GFiles?<cr>

" Sort the visual selection
vnoremap <leader>s :sort<cr>

" Format the visual selection with yapf, Yet Another Python Formatter
" 2018-09-09 TODO: Is there a nicer way to do this?
vnoremap <silent> <leader>f :<C-U>silent exec '%!yapf -l '.getpos("'<")[1].'-'.getpos("'>")[1].' %:p'<cr><cr>

" Forbid navigation by arrows
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" Inspired by tpope/vim-unimpaired
" Move to next buffer
nnoremap <silent> ]b :bnext<cr>

" Move to previous buffer
nnoremap <silent> [b :bprevious<cr>

" Move to next entry in quickfix list
nnoremap <silent> ]q :cnext<cr>

" Move to previous entry in quickfix list
nnoremap <silent> [q :cprev<cr>

" Insert a blank line below the current line
nnoremap <silent> ]<space> o<esc>k

" Insert a blank line above the current line
nnoremap <silent> [<space> O<esc>j

" Move to next error - w0rp/ale
nmap <silent> ]e <Plug>(ale_next_wrap)

" Move to previous error - w0rp/ale
nmap <silent> [e <Plug>(ale_previous_wrap)

" 'n' should always search FORWARD and 'N' BACKWARD
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Unmap ex-mode key bind because I keep hitting it and it baffles me
nnoremap Q <nop>

" Yank to end of line with Y
nnoremap Y y$

" Visually select entire buffer
nnoremap gV `[v`]

" A simple, easy-to-use Vim alignment plugin - junegunn/vim-easy-align
" Plugin requires recursive (map vs. noremap) bindings to work
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nnoremap <silent> <leader>r :Rg<cr>

" }}}
" Commands {{{

command! -nargs=1 SendKeysToTmux :silent call SendKeysToTmux(<args>)

function! SendKeysToTmux(cmd)
    call system("tmux send-keys -t bottom '" . a:cmd . "' C-m")
endfunction

" }}}
" Autocommands {{{

" Additional file type detection by extension
augroup filetypes
    autocmd!
    autocmd BufEnter *.sls     setlocal filetype=yaml
    autocmd BufEnter *.aurora  setlocal filetype=python
    autocmd BufEnter gitconfig setlocal filetype=gitconfig
    autocmd BufEnter todo.txt  setlocal filetype=todo
augroup END

" Set options for JavaScript
augroup filetype_javascript
    autocmd!
    autocmd FileType javascript setlocal shiftwidth=4
    autocmd FileType javascript setlocal tabstop=4
    autocmd FileType javascript setlocal textwidth=120
    autocmd FileType javascript setlocal colorcolumn=+1
augroup END

" Set options for Markdown
augroup filetype_markdown
    autocmd!
    autocmd FileType markdown setlocal shiftwidth=4
    autocmd FileType markdown setlocal tabstop=4
    autocmd FileType markdown nnoremap <buffer> <silent> <leader>g :Goyo<CR>
    autocmd FileType iabbrev <buffer> <expr> \t strftime("%m/%d/%Y")
augroup END

" Set options for Python
augroup filetype_python
    autocmd!
    autocmd FileType python setlocal shiftwidth=2
    autocmd FileType python setlocal tabstop=2
    autocmd FileType python setlocal textwidth=120
    autocmd FileType python setlocal colorcolumn=+1
augroup END

" Set options for shell scripts
augroup filetype_shell
    autocmd!
    autocmd FileType sh setlocal shiftwidth=2
    autocmd FileType sh setlocal tabstop=2
    autocmd FileType sh setlocal textwidth=80
    autocmd FileType sh setlocal colorcolumn=+1
    autocmd FileType sh setlocal comments=:#!,b:#/,b:#
augroup END

" Set options for todo.txt
augroup filetype_todotxt
    autocmd!
    autocmd BufEnter todo.txt iabbrev <buffer> <expr> \t strftime("%Y-%m-%d")
augroup END

" Set options for vimrc and vimscript
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal shiftwidth=4
    autocmd FileType vim setlocal tabstop=4
    autocmd FileType vim setlocal textwidth=120
    autocmd FileType vim setlocal colorcolumn=+1

    " Use :help on keyword when using K
    autocmd FileType vim setlocal keywordprg=:help

    " <leader>s sources the current Vimscript file, disables the current highlight, and reloads filetype
    autocmd FileType vim nnoremap <buffer> <silent> <leader>s :source % <bar> :nohlsearch <bar> :edit<CR>

    " Open help windows on the right, not below
    autocmd BufWinEnter *.txt if &filetype ==# 'help' | wincmd L | endif

    " Shortcut: `q` in normal mode closes the help window
    autocmd FileType help nnoremap <buffer> q :quit<CR>
augroup END

" Equally resize panes when vim resizes
augroup window_resized
    autocmd!
    autocmd VimResized * :wincmd =
augroup END

" }}}
" Local {{{

" Load local settings, if defined
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" }}}
