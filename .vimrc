" Set compatability to vim only
set nocompatible
" ==================
" BINDINGS
" ==================
" unbind default up/down
map j <Nop>
map k <Nop>
" dvorak movement
noremap h <left>
noremap t <down>
noremap n <up>
noremap s <right>
" window movement
noremap <C-H> :winc h<Enter>
noremap <C-S> :winc l<Enter>
noremap <C-W>t :winc j<Enter>
noremap <C-W>n :winc k<Enter>
" window moving
noremap <C-W>H :winc H<Enter>
noremap <C-W>S :winc L<Enter>
noremap <C-W>t :winc J<Enter>
noremap <C-W>n :winc K<Enter>
" fast movement
noremap T 10j
noremap N 10k
" rebind search
noremap l n
noremap L N
" tabs
noremap <C-T> :+tabnext<Enter>
noremap <C-N> :-tabnext<Enter>
" noremap <C-T> :winc h<Enter>
" noremap <C-N> :winc l<Enter>
" reload
noremap <C-R> :Reload<Enter>:nohl<Enter>

" ==================
" COMMANDS
" ==================
" to reload vim configuration
command Reload :source ~/.vimrc

" ==================
" FILETYPES
" ==================
" Helps force plug-ins to load correctly when turned back on below
filetype off

syntax on

" For plugins to load correctly
filetype plugin indent on

" =================
" FORMATTING
" =================
" wrap long lines
set wrap

" format options
" t = wrap text
" c = wrap comments
" q = allow comment formatting
" r = automaticaly insert comment leader
" n1 = recognize numbered lists
set formatoptions=tcqrn1

" tabs
" used to display actual tabs
set tabstop=8
" 'soft' tab width 
set softtabstop=4
set shiftwidth=4
" use spaces for tabs
set expandtab
" show whitespace
" shows >---- for tab characters, ~ for trailing spaces,
" and </> for text going off the screen
set listchars=tab:>-,trail:.,extends:>,precedes:<
set list

" when insertng tab round to multiple of shiftwidth
set shiftround

" ===================
" SETTINGS
" ==================

" tab complete
set wildmode=longest,list,full
set wildmenu

" allow more tabs
set tabpagemax=99

" number of lines to keep around the cursor
set scrolloff=5

" indicates fast tty connection
set ttyfast

" extra status line in multi window
set laststatus=2

" show mode in the status line
set showmode
" show command in status line
set showcmd

" add angle bracket pairs for xml
set matchpairs+=<:>

" display line number of current line
" and relative line number of the rest
set number
set relativenumber

" default encoding
set encoding=utf-8

" highlight search matches
set hlsearch
" search while typing
set incsearch
" match any case if search is lower case
" match case if search contains upper case
set ignorecase
set smartcase
set nowrapscan

" use system clipboard
set clipboard=unnamed
