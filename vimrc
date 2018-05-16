set nocompatible                " Turn off unnecessary vi compatibility
syntax enable

filetype plugin indent on

call plug#begin()

Plug 'tomasr/molokai'
Plug 'tomtom/tcomment_vim'
Plug 'vim-airline/vim-airline'
Plug 'pangloss/vim-javascript'
Plug 'mhinz/vim-sayonara'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'w0rp/ale'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'junegunn/vim-easy-align'
Plug 'mxw/vim-jsx'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()

" Color scheme
let g:rehash256 = 1
set t_Co=256
let base16colorspace=256
colorscheme molokai
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

" FZF
let g:fzf_layout = { 'down': '8' }

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
set formatoptions=qcj           " Auto-wrap comments, allow q in comments, remove comment leaders on join
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
set shortmess+=I
set showcmd
set showmatch
set showmode                    " Indicates if in insert mode
set smartcase
set smarttab
set softtabstop=2
set splitright
set splitbelow
set tabstop=2
set ttyfast                     " Yes, this is a fast terminal connection
set visualbell                  " Flash screen instead of annoying me
set wildignore+=node_modules,.git,apidoc,bower_components,dist
set wildmenu                    " Tab-completion for commands
set wildmode=list:full,longest  " List possible commands by length first

" Search and replace options
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Leader commands
let mapleader=","
nnoremap <leader>b :!exec %<cr>
nnoremap <leader><space> :noh<cr>
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j
nnoremap <leader>q :Sayonara!<cr>
nnoremap <leader>t :Files<cr>

" Forbid navigation by arrows
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Navigations inspired by unimpaired.vim
nnoremap <silent> ]b :bnext<cr>
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [q :cprev<cr>
nnoremap <silent> ]<space> o<esc>k
nnoremap <silent> [<space> O<esc>j
nmap <silent> ]e <Plug>(ale_next_wrap)
nmap <silent> [e <Plug>(ale_previous_wrap)

" 'n' should always search FORWARD and 'N' BACKWARD
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Unmap ex-mode key bind
nnoremap Q <nop>

vnoremap <leader>s :sort<cr>
nnoremap <leader>s vip:sort<cr>
nnoremap Y y$
nmap gV `[v`]

let g:airline_powerline_fonts = 1

if has("gui_running" )
    set guifont=Inconsolata-dz_for_Powerline:h10
    set antialias
end

augroup filetypes
    au!
    au BufEnter *.sls setlocal filetype=yaml
    au BufEnter *.aurora setlocal filetype=python
augroup END

augroup spacing
    au!
    au FileType sh         setlocal sw=2 ts=2 tw=80 colorcolumn=+1 comments=:#!,b:#/,b:#
    au FileType javascript setlocal sw=4 ts=4 tw=120 colorcolumn=+1
    au FileType python     setlocal sw=4 ts=4 tw=120 colorcolumn=+1
    au FileType markdown   setlocal sw=4 ts=4
augroup END

" vim-javascript
let g:javascript_plugin_jsdoc = 1

" ALE
let g:ale_sign_column_always = 1
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_echo_msg_format = '[%severity%/%linter%] %s'

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

hi MatchParen      ctermfg=208  ctermbg=233 cterm=bold

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
