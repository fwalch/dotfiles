" -- Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

" -- Plugins

Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-vividchalk'
Bundle 'CSApprox'
Bundle 'Rip-Rip/clang_complete'
Bundle 'kchmck/vim-coffee-script'
Bundle 'scrooloose/syntastic'

" +----------------+
" | Basic settings |
" +----------------+

filetype plugin indent on         " Turn on different indentations for fts

" To support color scheme in graphical terminals
if &term == 'linux'
  let CSApprox_loaded = 1         " Disable CSApprox in virtual console
else
  set t_Co=256                    " Force colors
endif

syntax on                         " Turn on syntax highlighting
set encoding=utf-8                " UTF-8 encoding
set showcmd                       " Displays command in last line
set showmode                      " Displays mode in last line
set wildmenu                      " Displays tab completion above status line
set cursorline                    " Highlight current line
set modelines=0                   " Disable modelines
set ttyfast                       " Faster redrawing in terminal
set visualbell                    " Visual bell instead of beeping
set hidden                        " Allow hidden buffers
set shell=zsh                     " Use zsh
silent! colorscheme vividchalk    " Use vividchalk color scheme
highlight SignColumn guibg=Black ctermbg=Black
highlight CursorLine term=bold cterm=bold

" -- Backup/Swap etc.
set nobackup                      " No backup files
set nowritebackup                 " No backup files
set dir=~/.vimswap//,/tmp//       " Swap Directory
set undodir=~/.vimundo//,/tmp//   " Undo Directory
set undofile                      " Use undo-file features

" -- Searching
set incsearch                     " Incremental search
set hlsearch                      " Highlight search words
set ignorecase                    " Search is case-insensitive ...
set smartcase                     " ... unless it contains a capital letter

" -- Completion
set completeopt=menuone           " Show completion menu, also if only one match

" -- Side-/Statusbar
set ruler                         " Show current position in status bar
set number                        " Show line number
set laststatus=2                  " Always display status line
set relativenumber                " Show relative line numbers

" -- Indentation etc.
set tabstop=2                     " 2 spaces equal one tab
set softtabstop=2                 " 2 spaces equal one tab
set shiftwidth=2                  " Auto-indent spaces
set expandtab                     " Use spaces instead of tabs
set backspace=indent,eol,start    " Backspacing over everything

set list                          " Mark whitespace
set listchars=trail:░             " Mark trailing whitespace

" +--------------+
" | Key mappings |
" +--------------+

let mapleader=","                 " ',' is the leader character

" -- Map F1 to ESC
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Map C-H,J,K,L to arrow keys in command mode (like CTRL+P settings)
cnoremap <C-H> <Left>
cnoremap <C-J> <Down>
cnoremap <C-K> <Up>
cnoremap <C-L> <Right>

" Map Leader-P to paste last yanked content
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P

" Map CTRL-J and CTRL-K to move through completion
inoremap <C-J> <C-N>
inoremap <C-K> <C-P>

" +-----------------------+
" | surround.vim settings |
" +-----------------------+

nmap s ys
nmap S yS
vmap s S
let g:rails_syntax = 0

" +-----------------+
" | CTRL+P settings |
" +-----------------+

let g:ctrlp_match_window_bottom = 0 " Show on top of the screen
let g:ctrlp_dotfiles = 0            " Don't search dotfiles
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = '\.class$\|\vendor/bundle$|\tmp$'

" +-------------------------+
" | clang_complete settings |
" +-------------------------+

let g:clang_use_library = 1

" +--------------------+
" | syntastic settings |
" +--------------------+

let g:syntastic_check_on_open = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

