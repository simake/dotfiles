call plug#begin('~/.vim/plugged')

Plug 'dracula/vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

call plug#end()

colorscheme dracula

set encoding=utf-8

set number
set hlsearch
set incsearch
set timeoutlen=200

set backspace=indent,eol,start

set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent

let mapleader = "\<Space>"
nnoremap <space> <Nop>

inoremap jk <Esc>
inoremap kj <Esc>
cnoremap jk <C-c>
cnoremap kj <C-c>

nnoremap <silent> <leader><space> :nohlsearch<CR>

