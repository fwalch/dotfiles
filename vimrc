filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

" -- Plugins

" Theme
Bundle 'sjl/badwolf'
" CoffeeScript support
Bundle 'kchmck/vim-coffee-script'
" Ruby support
Bundle 'vim-ruby/vim-ruby'

" File finder
Bundle 'kien/ctrlp.vim'
" * search in visual mode
Bundle 'nelstrom/vim-visual-star-search'
" Statusline
Bundle 'Lokaltog/vim-powerline'
" Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim'}
" Matchit
Bundle 'matchit.zip'
" Code completion
Bundle 'Valloric/YouCompleteMe'
" Syntax checking
Bundle 'scrooloose/syntastic'
" Automatic ctags updating
Bundle 'basilgor/vim-autotags'
" List movement key mappings
Bundle 'tpope/vim-unimpaired'
" Movement
Bundle 'Lokaltog/vim-easymotion'

" +----------------+
" | Basic settings |
" +----------------+

filetype plugin indent on

if &term == 'linux'
  silent! colorscheme darkblue
else
  silent! colorscheme badwolf
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
set shell=zsh                     " Use zsh

" -- Color scheme modifications
highlight SyntasticError ctermbg=darkblue guibg=blue
highlight SyntasticWarning ctermbg=darkgreen guibg=darkgreen
highlight CursorLine term=bold cterm=bold gui=bold

" -- Backup/Swap etc.
set undofile                      " Use undo-file features
set backupdir=~/.vtmp/b//,/tmp//  " Backup directory
set dir=~/.vtmp/s//,/tmp//        " Swap directory
set undodir=~/.vtmp/u//,/tmp//    " Undo directory

" -- Searching
set incsearch                     " Incremental search
set hlsearch                      " Highlight search words
set ignorecase                    " Search is case-insensitive ...
set smartcase                     " ... unless it contains a capital letter

" -- Completion
set completeopt=menuone           " Show completion menu, also if only one match

" -- Side-/Statusbar
set ruler                         " Show current position in status bar
set laststatus=2                  " Always display status line
set noshowmode                    " Hide mode text below status line
set relativenumber                " Show relative line numbers

" -- Indentation etc.
set tabstop=2                     " 2 spaces equal one tab
set softtabstop=2                 " 2 spaces equal one tab
set shiftwidth=2                  " Auto-indent spaces
set expandtab                     " Use spaces instead of tabs
set backspace=indent,eol,start    " Backspacing over everything

set list                          " Mark whitespace
set listchars=trail:␣             " Mark trailing whitespace

" +--------------+
" | Key mappings |
" +--------------+

let mapleader="ö"

nnoremap <F5> :make<CR>

" Switch , and ; in normal mode
" I don't want to hit Shift to move forward! (German layout)
nnoremap , ;
nnoremap ; ,

" Map CTRL-J and CTRL-K to move through completion
inoremap <C-J> <C-N>
inoremap <C-K> <C-P>

" Map preview tag movements (similar to vim-unimpaired)
nnoremap ]p :ptnext<CR>
nnoremap [p :ptprev<CR>
nnoremap ]P :ptlast<CR>
nnoremap [P :ptfirst<CR>

" Plugin mappings
nnoremap <F6> :YcmForceCompileAndDiagnostics<CR>

" +-------------------+
" | autotags settings |
" +-------------------+

let g:autotags_no_global=1

" +-----------------+
" | CTRL-P settings |
" +-----------------+

let g:ctrlp_custom_ignore='\.class$\|\vendor/bundle$|\tmp$|\.o$'
let g:ctrlp_by_filename=1 " Search only filename by default

" +--------------------+
" | syntastic settings |
" +--------------------+

let g:syntastic_enable_signs=0
let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1

let g:syntastic_c_checkers=['ycm']
let g:syntastic_cpp_checkers=['ycm']
let g:syntastic_tex_checkers=['chktex']
let g:syntastic_ruby_checkers=['mri']

" +------------------------+
" | YouCompleteMe settings |
" +------------------------+

let g:ycm_confirm_extra_conf=0         " Don't ask when opening ycm config file
let g:ycm_add_preview_to_completeopt=1
let g:ycm_autoclose_preview_window_after_insertion=1

" +--------------------+
" | powerline settings |
" +--------------------+

let g:Powerline_symbols = 'compatible'
let g:Powerline_symbols_override={
  \ 'LINE': '¶',
  \ 'RO': '✗',
  \ }

" +---------------------+
" | EasyMotion settings |
" +---------------------+

let g:EasyMotion_leader_key = '<Leader>'

" Source local extra config file if it exists
let s:extra_config = getcwd() .'/.vim_extra_conf.vim'
if filereadable(s:extra_config)
  execute 'source'. s:extra_config
endif
