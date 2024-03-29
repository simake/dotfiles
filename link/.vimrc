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
Plug 'nelstrom/vim-visual-star-search'
Plug 'wincent/scalpel'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-sayonara'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ap/vim-buftabline'
Plug 'ajh17/VimCompletesMe'

call plug#end()

"  ----------------------------------------------------------------
" |                        General Settings                        |
"  ----------------------------------------------------------------

set background=dark
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

" Indicate continuation of lines when they don't fit on screen
set listchars=extends:>,precedes:<
set list

" More intuitive location for new splits
set splitbelow
set splitright

" Remove comment leader when joining lines
set formatoptions+=j

" Allow cursor to move where there is no text in visual block mode
if has('virtualedit')
    set virtualedit=block
endif

" Use 24-bit colors for better color accuracy
if has('termguicolors')
    set termguicolors
endif

" Speed up macro playback
set lazyredraw

" Enable using the mouse for scrolling, selecting, etc.
set mouse=a
" TODO: Set different mouse shapes depending on mode

" Sync yank register with system clipboard
if has('unnamedplus')
    set clipboard=unnamedplus
endif

" Start scrolling before cursor reaches all the way to the top or bottom
set scrolloff=3

" Gather all swap files in one place where they don't get in the way
if !isdirectory($HOME."/.vim/swap")
    call mkdir($HOME."/.vim/swap", "p")
endif
set directory^=$HOME/.vim/swap//

" Activate backups and keep them out of the way
set backup
if !isdirectory($HOME."/.vim/backup")
    call mkdir($HOME."/.vim/backup", "p")
endif
set backupdir^=$HOME/.vim/backup

" Activate persistent undo and keep it out of the way
set undofile
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "p")
endif
set undodir^=$HOME/.vim/undo

"  ----------------------------------------------------------------
" |                      General Keymappings                       |
"  ----------------------------------------------------------------

let mapleader = "\<Space>"
nnoremap <space> <Nop>

" Convenient maps for returning to normal mode
inoremap jk <Esc>
inoremap kj <Esc>
cnoremap jk <C-c>
cnoremap kj <C-c>
tnoremap jk <Esc>
tnoremap kj <Esc>

" Hide search highlighting
nnoremap <silent> <space><space> :nohlsearch<CR>

" Window management (mnemonic: split)
nnoremap <silent> <leader>sh :leftabove vsplit<CR>
nnoremap <silent> <leader>sj :rightbelow split<CR>
nnoremap <silent> <leader>sk :leftabove split<CR>
nnoremap <silent> <leader>sl :rightbelow vsplit<CR>
nnoremap <silent> <leader>so :only<CR>

" Window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer management
nnoremap <silent> <leader>bn :enew<CR>

" Buffer movement
nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>

" Make Y consistent with C and D
nnoremap Y y$

" Remap Q from Ex mode to something useful (macros)
" qq to start recording, q to stop, Q to play
nnoremap Q @q

" Prevent x and c from overwriting registers/clipboard
nnoremap x "_x
vnoremap x "_x
nnoremap c "_c

" Toggle relative numbers
nnoremap <silent> <leader>tr :set relativenumber!<CR>

" Toggle between window-local and global working directories
function! ToggleLocalCWD()
    if expand('%:p:h') == getcwd(-1)
        echo getcwd()
    elseif haslocaldir()
        execute 'cd' getcwd(-1)
        echo getcwd() . ' (global)'
    else
        :lcd %:p:h
        echo getcwd() . ' (local)'
    endif
endfunction

nnoremap <leader>cd :call ToggleLocalCWD()<CR>

"  ----------------------------------------------------------------
" |                     Plugin Configuration                       |
"  ----------------------------------------------------------------

" Use the following autocmd group to modify plugins post loading.
" Define a function and hook it up with:
" autocmd after VimEnter * call func()
augroup after
    autocmd!
augroup END

" ============ junegunn/fzf.vim ============

" Find file {tracked by git,}
nnoremap <silent> ,f :GFiles<CR>
nnoremap <silent> ,,f :Files<CR>

" Find file in a specified directory
nnoremap ,F :Files<Space>

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
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'up': '~40%' }

" ========== scrooloose/nerdtree ===========

nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>N :NERDTreeFind<CR>

let g:NERDTreeMapOpenSplit='s'
let g:NERDTreeMapPreviewSplit='gs'
let g:NERDTreeMapOpenVSplit='v'
let g:NERDTreeMapPreviewVSplit='gv'

let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeAutoDeleteBuffer=1

" These interfere with my window movement (<C-j> and <C-k>)
let g:NERDTreeMapJumpPrevSibling='<Nop>'
let g:NERDTreeMapJumpNextSibling='<Nop>'

" ========= airblade/vim-gitgutter =========

let g:gitgutter_map_keys = 0

nnoremap <silent> <leader>gg :GitGutterToggle<CR>
nnoremap <silent> <leader>hj :GitGutterNextHunk<CR>
nnoremap <silent> <leader>hk :GitGutterPrevHunk<CR>
nnoremap <silent> <leader>hs :GitGutterStageHunk<CR>
nnoremap <silent> <leader>hu :GitGutterUndoHunk<CR>
nnoremap <silent> <leader>hp :GitGutterPreviewHunk<CR>

function! ConditionalGitGutter()
    " Only execute if typeahead buffer is empty (not during macros)
    if getchar(1) == 0
        :GitGutter
    endif
endfunction

function! AfterGitGutter()
    augroup gitgutter
        " Turn off realtime update of the git gutter
        autocmd! CursorHold,CursorHoldI *
        " Update on changing text in normal mode
        " or exiting insert mode instead.
        autocmd! TextChanged,InsertLeave * call ConditionalGitGutter()
        " Note: The conditional execution solves the problem of slow macros
    augroup END
endfunction

autocmd after VimEnter * call AfterGitGutter()

" =========== mhinz/vim-sayonara ===========

" I may finally be able to exit vim
nnoremap <silent> <leader>q :Sayonara<CR>
nnoremap <silent> <leader>Q :Sayonara!<CR>

" Write and close modified buffers/windows easily
nnoremap <leader>ww :write<CR>
nnoremap <leader>xx :write<bar>:Sayonara<CR>

" ===== ntpeters/vim-better-whitespace =====

nnoremap <silent> <leader>tw :ToggleWhitespace<CR>
" :StripWhitespace is also useful

" ========== ajh17/VimCompletesMe ==========

" Accept autocomplete suggestion on enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

"  ----------------------------------------------------------------
" |                       Filetype settings                        |
"  ----------------------------------------------------------------

" THIS SHOULD PROBABLY USE ~/.vim/ftplugin/*.vim INSTEAD

augroup template_settings
    autocmd!
    autocmd filetype template echo "example"
augroup end

"  ----------------------------------------------------------------
" |                              Misc                              |
"  ----------------------------------------------------------------

function! SourceIfExists(file)
    if filereadable(expand(a:file))
        execute 'source' a:file
    endif
endfunction

" Allow for per-machine overrides of settings
call SourceIfExists('~/.vimrc.local')

