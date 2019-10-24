call plug#begin('~/.vim/plugged')

Plug 'dracula/vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

call plug#end()

colorscheme dracula

set number

inoremap ii <Esc>
inoremap jk <Esc>
inoremap kj <Esc>
inoremap jj <Esc>
inoremap df <Esc>
inoremap fd <Esc>

cnoremap jk <C-c>
cnoremap kj <C-c>

set timeoutlen=200
