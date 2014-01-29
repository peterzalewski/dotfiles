set nocompatible                " Turn off unnecessary vi compatibility
set encoding=utf-8              " Sane encoding standard
syntax enable

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
filetype plugin indent on

" General options
set modelines=0                 " Who uses modelines?
set scrolloff=2                 " 2 lines of context for jumping to search results
set autoindent                  " Love autoindent
set showmode                    " Indicates if in insert mode 
set showcmd                     " Displays size of current selection
set hidden                      " Hides buffers instead of closing them
set wildmenu                    " Tab-completion for commands
set wildmode=list:full,longest  " List possible commands by length first
set visualbell                  " Flash screen instead of annoying me
set ttyfast                     " Yes, this is a fast terminal connection
set ruler                       " X,Y in file
set relativenumber              " Line numbers are relative to current line
set backspace=eol,indent,start  " Backspace over every goddamn thing
set laststatus=2                " Additional status line
set nostartofline               " Don't always jump to start of line

" Sane tab/space handling
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Stop leaving little files everywhere
set nobackup
set nowritebackup
set noswapfile

" Search and replace options
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" LEADER commands
let mapleader=","
nnoremap <leader>b :!exec %<cr>
nnoremap <leader><space> :noh<cr>
nnoremap <leader>w <C-w>v<C-w>l

" Be a MAN
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap jj <Esc>

" Split windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Switch buffers
nnoremap <C-Tab> :bnext<cr>
nnoremap <C-S-Tab> :bprevious<cr>

" Color scheme
set background=dark
colorscheme solarized

if has("gui_running" )
    set guifont=Inconsolata-dz_for_Powerline:h10
    let g:Powerline_symbols = 'fancy'
    set antialias
end

if has("gui_macvim")
    set fuoptions=maxhorz,maxvert
end
