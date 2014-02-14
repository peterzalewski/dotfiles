set nocompatible                " Turn off unnecessary vi compatibility
syntax enable

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" Color scheme
let g:rehash256 = 1
colorscheme molokai

" General options
set autoindent
set autoread
set backspace=eol,indent,start
set encoding=utf8
set expandtab
set fileformats=unix,mac,dos
set fillchars=vert:\│           " Handsome vertical split character
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
set ruler                       " X,Y in file
set scrolloff=2                 " 2 lines of context for jumping to search results
set shiftround
set shiftwidth=4
set showcmd
set showmatch
set showmode                    " Indicates if in insert mode 
set smartcase
set smarttab
set softtabstop=4
set tabstop=4
set ttyfast                     " Yes, this is a fast terminal connection
set visualbell                  " Flash screen instead of annoying me
set wildignore+=node_modules,.git,apidoc,bower_components
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
let g:ctrlp_map = "<leader>t"

" Forbid navigation by arrows
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap jj <Esc>

" Switch buffers
nnoremap <leader><Tab> :bnext<cr>
nnoremap <leader><S-Tab> :bprevious<cr>

let g:airline_powerline_fonts = 1

if has("gui_running" )
    set guifont=Inconsolata-dz_for_Powerline:h10
    set antialias
end

if has("gui_macvim")
    set fuoptions=maxhorz,maxvert
end

nnoremap <silent> <leader>e :call JSFormat()<cr>

function! JSFormat()
    let l:win_view = winsaveview()
    let l:last_search = getreg('/')

    execute ":%!esformatter --indent.value=\"    \""
    if v:shell_error
        echoerr "esformatter error!"
        undo
        return 0
    endif

    call winrestview(l:win_view)
    call setreg('/', l:last_search)
endfunction
