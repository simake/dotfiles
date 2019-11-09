"  ----------------------------------------------------------------
" |                            Plugins                             |
"  ----------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'dracula/vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ntpeters/vim-better-whitespace'
Plug 'wincent/scalpel'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

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

" Enable using the mouse for scrolling, selecting, etc.
set mouse=a
" TODO: Set different mouse shapes depending on mode

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
tnoremap jk <Esc>
tnoremap kj <Esc>

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

" ============ junegunn/fzf.vim ============

" Find file {tracked by git,}
nnoremap <silent> ,f :GFiles<CR>
nnoremap <silent> ,,f :Files<CR>

" Find line in {current buffer,loaded buffers}
nnoremap <silent> ,l :BLines<CR>
nnoremap <silent> ,,l :Lines<CR>

" Find tag in {current buffer,project}
nnoremap <silent> ,t :BTags<CR>
nnoremap <silent> ,,t :Tags<CR>

" Find commit {associated with current buffer,}
nnoremap <silent> ,gc :BCommits!<CR>
nnoremap <silent> ,,gc :Commits!<CR>

" Find {command,keymappings,filetypes,help,ultisnips}
nnoremap <silent> ,: :Commands<CR>
nnoremap <silent> ,k :Maps<CR>
nnoremap <silent> ,y :Filetypes<CR>
nnoremap <silent> ,h :Helptags<CR>
nnoremap <silent> ,s :Snippets<CR>

" Browse open buffers
nnoremap <silent> ,b :Buffers<CR>

" Find past {file,command,search} (history)
nnoremap <silent> ,pf :History<CR>
nnoremap <silent> ,p: :History:<CR>
nnoremap <silent> ,p/ :History/<CR>

" Recursively search files in current directory for regex pattern
nnoremap ,/ :Rg<Space>

" git status
nnoremap <silent> <leader>gs :GFiles!?<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'up': '~40%' }

" ========== scrooloose/nerdtree ===========

nnoremap <silent> <leader>n :NERDTreeToggle<CR>

let NERDTreeMapOpenSplit="h"
let NERDTreeMapPreviewSplit="gh"
let NERDTreeMapOpenVSplit="v"
let NERDTreeMapPreviewVSplit="gv"

let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer=1

" ========= airblade/vim-gitgutter =========

augroup gitgutter
    " Turn off realtime update of the git gutter
    autocmd! CursorHold,CursorHoldI *
    " Update on changing text in normal mode
    " or exiting insert mode instead.
    autocmd TextChanged,InsertLeave * GitGutter
    " Note: This could slow down macros with a lot
    " of text-changing commands. I will monitor closely.
augroup END

nnoremap <silent> <leader>gg :GitGutterToggle<CR>

