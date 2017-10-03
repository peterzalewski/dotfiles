set nocompatible                " Turn off unnecessary vi compatibility
syntax enable

filetype plugin indent on

call plug#begin()

Plug 'mileszs/ack.vim'
Plug 'tomasr/molokai'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'vim-airline/vim-airline'
Plug 'pangloss/vim-javascript'
Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-repeat'
Plug 'mhinz/vim-sayonara'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'junegunn/vim-easy-align'
Plug 'mxw/vim-jsx'

call plug#end()

" Color scheme
let g:rehash256 = 1
set t_Co=256
let base16colorspace=256
colorscheme molokai
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

" General options
set autoindent
set autoread
set backspace=eol,indent,start
set encoding=utf8
set expandtab
set fileformats=unix,mac,dos
set fillchars=vert:\│           " Handsome vertical split character
set foldmethod=indent
set foldlevelstart=20
set gdefault
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2                " Additional status line
set lazyredraw                  " Do not redraw unnecessarily
set nobackup
set nojoinspaces
set nostartofline               " Don't always jump to start of line
set noswapfile
set nowritebackup
set relativenumber              " Line numbers are relative to current line
set number                      " But also show absolute line no
set ruler                       " X,Y in file
set scrolloff=2                 " 2 lines of context for jumping to search results
set shiftround
set shiftwidth=2
set showcmd
set showmatch
set showmode                    " Indicates if in insert mode 
set smartcase
set smarttab
set softtabstop=2
set tabstop=2
set ttyfast                     " Yes, this is a fast terminal connection
set visualbell                  " Flash screen instead of annoying me
set wildignore+=node_modules,.git,apidoc,bower_components,dist
set wildmenu                    " Tab-completion for commands
set wildmode=list:full,longest  " List possible commands by length first

" Search and replace options
nnoremap / /\v
vnoremap / /\v

" Leader commands
let mapleader=","
nnoremap <leader>b :!exec %<cr>
nnoremap <leader><space> :noh<cr>
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j
nnoremap <leader>q :Sayonara!<cr>
let g:ctrlp_map = "<leader>t"

let g:ctrlp_custom_ignore = '\v.pyc$'

" Forbid navigation by arrows
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Switch buffers
nnoremap <leader><Tab> :bnext<cr>
nnoremap <leader><S-Tab> :bprevious<cr>

" 'n' should always search FORWARD and 'N' BACKWARD
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

let g:airline_powerline_fonts = 1

if has("gui_running" )
    set guifont=Inconsolata-dz_for_Powerline:h10
    set antialias
end

if has("gui_macvim")
    set fuoptions=maxhorz,maxvert
end

augroup configgroup
    autocmd!
    autocmd BufEnter *.sls setlocal filetype=yaml
    autocmd BufEnter *.aurora setlocal filetype=python
augroup END

autocmd FileType * setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 colorcolumn=100
autocmd FileType python setlocal shiftwidth=4 tabstop=4

" ale
let g:ale_python_pylint_options = '--rcfile=/Users/pzalewski/Code/data/.arc/.pylintrc'
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['pylint']
\}

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
