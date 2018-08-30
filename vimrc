set nocompatible                " Turn off unnecessary vi compatibility
syntax enable

filetype plugin indent on

call plug#begin()

" Molokai color scheme
Plug 'tomasr/molokai'

" Comment lines and blocks, sensitive to file type
Plug 'tomtom/tcomment_vim'

" Lightweight status line
Plug 'vim-airline/vim-airline'

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

call plug#end()

" Color scheme
let g:rehash256 = 1
set t_Co=256
let base16colorspace=256
colorscheme molokai
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
hi MatchParen      ctermfg=208  ctermbg=233 cterm=bold

" FZF
let g:fzf_layout = { 'down': '8' }

" General options
set autoindent                 " Copy indent from current line when starting new line
set autoread                   " Re-read files changed outside of vim
set backspace=eol,indent,start " Backspace over EOL, indents, and start of line in insert mode
set clipboard=unnamed          " Yank to system clipboard
set encoding=utf8              " Default to UTF-8 everywhere, including registers
set expandtab                  " Convert tabs to spaces in insert mode
set fileformats=unix,mac,dos   " Set EOL preferences and default to Unix line endings
set fillchars=vert:\│          " Handsome vertical split character
set foldlevelstart=20          " Edit files with first 20 levels of folds open
set foldmethod=indent          " Fold lines with equal indent levels
set formatoptions=qcj          " Auto-wrap comments, allow q in comments, remove comment leaders on join
set gdefault                   " Substitutes are global on the current line by default
set hidden                     " Abandoning hides buffers rather than unloads them
set hlsearch                   " Highlight search results
set ignorecase                 " Ignore case in search patterns
set incsearch                  " Show first match as you type pattern
set laststatus=2               " Additional status line
set lazyredraw                 " Do not redraw unnecessarily
set nobackup                   " Do not keep backups after overwriting files
set nojoinspaces               " Only insert one space when joining lines
set nostartofline              " Don't always jump to start of line
set noswapfile                 " Do not create swap files
set nowritebackup              " Do not create backups when writing files
set number                     " Show absolute line number on current line
set relativenumber             " Line numbers are relative to current line
set ruler                      " Display row and column in file
set scrolloff=2                " 2 lines of context for jumping to search results
set shiftround                 " Round indents to multiple of 'shiftwidth'
set shiftwidth=2               " Indent by 2 spaces
set shortmess+=I               " Do not display the vim intro message on start
set showcmd                    " Show last command below status line
set showmatch                  " Briefly jump to matching bracket after inserting one
set showmode                   " Indicates if in insert mode
set smartcase                  " Default to case-insensitive search pattern until typing a capital letter
set smarttab                   " Use 'shiftwidth' spaces when typing tab at beginning of line
set softtabstop=2              " Use 2 spaces when typing tab anywhere
set splitbelow                 " Default to opening new horizontal split BELOW current one
set splitright                 " Default to opening new vertical split to RIGHT of current one
set tabstop=2                  " Display tabs with 2 spaces
set ttyfast                    " Yes, this is a fast terminal connection
set visualbell                 " Flash screen instead of annoying me
set wildignore+=node_modules   " Ignore node_modules when expanding wildcards and completing filenames
set wildignore+=.git           " Ignore .git when expanding wildcards and completing filenames
set wildmenu                   " Tab-completion for commands
set wildmode=list:full,longest " List possible commands by length first

" Search and replace options
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

" Close the buffer but keep the window open
nnoremap <leader>q :Sayonara!<cr>

" Search files with FZF
nnoremap <leader>t :Files<cr>

" Search buffers with FZF
nnoremap <leader>b :Buffers<cr>

" Sort the visual selection
vnoremap <leader>s :sort<cr>

" Format the visual selection with yapf, Yet Another Python Formatter
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

" Inspired by unimpaired.vim
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

" Move to next error reported by ALE
nmap     <silent> ]e <Plug>(ale_next_wrap)

" Move to previous error reported by ALE
nmap     <silent> [e <Plug>(ale_previous_wrap)

" 'n' should always search FORWARD and 'N' BACKWARD
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Unmap ex-mode key bind
nnoremap Q <nop>

" Yank to end of line with Y
nnoremap Y y$

" Visually select entire buffer
nmap gV `[v`]

augroup filetypes
    au!
    au BufEnter *.sls    setlocal filetype=yaml
    au BufEnter *.aurora setlocal filetype=python
augroup END

augroup spacing
    au!
    au FileType javascript setlocal sw=4 ts=4 tw=120 colorcolumn=+1
    au FileType markdown   setlocal sw=4 ts=4
    au FileType python     setlocal sw=4 ts=4 tw=120 colorcolumn=+1
    au FileType sh         setlocal sw=2 ts=2 tw=80  colorcolumn=+1 comments=:#!,b:#/,b:#
augroup END

" vim-airline/vim-airline
let g:airline_powerline_fonts = 1

" pangloss/vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow  = 1

" w0rp/ale
let g:ale_sign_column_always   = 1
let g:ale_echo_msg_error_str   = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format      = '[%severity%/%linter%] %s'

" junegunn/vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
