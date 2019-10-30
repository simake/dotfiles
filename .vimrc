"  ----------------------------------------------------------------
" |                            Plugins                             |
"  ----------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'dracula/vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ntpeters/vim-better-whitespace'

call plug#end()

"  ----------------------------------------------------------------
" |                        General Settings                        |
"  ----------------------------------------------------------------

:silent! colorscheme dracula

set encoding=utf-8
set timeoutlen=300
set hidden

" Use hybrid line numbering
set number
set relativenumber

" Activate search highlighting
set hlsearch
set incsearch

" Allow backspacing over indentation, newlines, and the start of an insert
set backspace=indent,eol,start

" Use soft tabs of 4 spaces by default
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent

" More intuitive location for new splits
set splitbelow
set splitright

" Gather all swap files in one place where they don't get in the way
if !isdirectory($HOME."/.vim/swap")
    call mkdir($HOME."/.vim/swap", "p")
endif
set directory^=$HOME/.vim/swap//

"  ----------------------------------------------------------------
" |                      General Keymappings                       |
"  ----------------------------------------------------------------

let mapleader = "\<Space>"
nnoremap <space> <Nop>

" Conveniet maps for returning to normal mode
inoremap jk <Esc>
inoremap kj <Esc>
cnoremap jk <C-c>
cnoremap kj <C-c>

" Hide search highlighting
nnoremap <silent> <space><space> :nohlsearch<CR>

" Cycle splits
nnoremap <C-J> <C-W>w
nnoremap <C-K> <C-W>W

" Toggle relative numbers
nnoremap <silent> <leader>r :set relativenumber!<CR>

"  ----------------------------------------------------------------
" |                     Plugin Configuration                       |
"  ----------------------------------------------------------------

