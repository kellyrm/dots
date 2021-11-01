" Set compatability to vim only
set nocompatible

" dvorak
map j <Nop>
map k <Nop>
noremap h <left>
noremap t <down>
noremap n <up>
noremap s <right>

noremap l n
noremap L N

" Helps force plug-ins to load correctly when turned back on below
filetype off

syntax on

" For plugins to load correctly
filetype plugin indent on

set wrap

set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

set scrolloff=5
set backspace=indent,eol,start

set ttyfast

set laststatus=2

set showmode
set showcmd

set matchpairs+=<:>

set number

set encoding=utf-8


set hlsearch
set incsearch
set ignorecase
set smartcase

set clipboard=unnamed

set viminfo='100,<9999,s100


execute pathogen#infect()

