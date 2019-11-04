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

" ============ junegunn/fzf.vim ============

" Find file {,tracked by git}
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fgf :GFiles<CR>

" Find line in {loaded buffers,current buffer}
nnoremap <silent> <leader>fl :Lines<CR>
nnoremap <silent> <leader>fbl :BLines<CR>

" Find commit {,associated with current buffer}
nnoremap <silent> <leader>fc :Commits<CR>
nnoremap <silent> <leader>fbc :BCommits<CR>

" Find {command,keymappings,filetypes}
nnoremap <silent> <leader>f: :Commands<CR>
nnoremap <silent> <leader>fk :Maps<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

" Recursively search files in current directory for regex pattern
nnoremap <silent> <leader>rg :Rg<Space>

" Browse open buffers
nnoremap <silent> <leader>b :Buffers<CR>

" Show {file,command,search} history
nnoremap <silent> <leader>hf :History<CR>
nnoremap <silent> <leader>h: :History:<CR>
nnoremap <silent> <leader>h/ :History/<CR>

" git status
nnoremap <silent> <leader>gs :GFiles?<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }

" ========== scrooloose/nerdtree ===========

nnoremap <silent> <leader>n :NERDTreeToggle<CR>

let NERDTreeMapOpenSplit="h"
let NERDTreeMapPreviewSplit="gh"
let NERDTreeMapOpenVSplit="v"
let NERDTreeMapPreviewVSplit="gv"

let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer=1

" =========airblade/vim-gitgutter'==========

augroup gitgutter
    " Turn off realtime update of the git gutter
    autocmd! CursorHold,CursorHoldI *
    " Update on exiting insert mode instead
    " Note: This could slow down macros that repeat
    " a lot of insert commands. I will monitor closely.
    autocmd InsertLeave * GitGutter
augroup END

" Use a hotkey instead
"nnoremap <silent> <expr> <leader>gg g:gitgutter_enabled ?
"    \ ':GitGutterDisable<CR>':':GitGutterEnable<CR>'
nnoremap <silent> <leader>gg :GitGutterToggle<CR>

