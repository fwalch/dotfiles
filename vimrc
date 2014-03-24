filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

" -- Plugins

Bundle 'sjl/badwolf'

Bundle 'kchmck/vim-coffee-script'
Bundle 'vim-ruby/vim-ruby'
Bundle 'derekwyatt/vim-scala'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'kien/ctrlp.vim'
Bundle 'bling/vim-airline'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
Bundle 'Raimondi/delimitMate'
"Bundle 'gilligan/vim-lldb'

" +----------------+
" | Basic settings |
" +----------------+

filetype plugin indent on

" Modify color scheme for each terminal
if &term == 'linux'
  silent! colorscheme darkblue
  highlight SyntasticError ctermbg=darkblue
  highlight SyntasticWarning ctermbg=darkgreen
else
  silent! colorscheme badwolf
  highlight SyntasticError ctermbg=196 guibg=#ff2c4b ctermfg=15 guifg=#f9f6f2 cterm=bold term=bold gui=bold
  highlight SyntasticWarning ctermbg=214 guibg=#ffa724 ctermfg=15 guifg=#f9f6f2 cterm=bold term=bold gui=bold
endif

highlight CursorLine term=bold cterm=bold gui=bold

syntax on                         " Turn on syntax highlighting
set encoding=utf-8                " UTF-8 encoding
set showcmd                       " Displays command in last line
set showmode                      " Displays mode in last line
set wildmenu                      " Displays tab completion above status line
set cursorline                    " Highlight current line
set modelines=0                   " Disable modelines
set ttyfast                       " Faster redrawing in terminal
set visualbell                    " Visual bell instead of beeping

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

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

" -- Spell checking
set spelllang=en_us,de
set spellfile=~/.vim/spell/fwalch.utf-8.add

" -- Completion
set completeopt=menuone           " Show completion menu, also if only one match

" -- Side-/Statusbar
set ruler                         " Show current position in status bar
set laststatus=2                  " Always display status line
set noshowmode                    " Hide mode text below status line
set relativenumber                " Show relative line numbers

" -- Window management
set splitright                    " Create vertical splits on the right

" -- Indentation etc.
set tabstop=2                     " 2 spaces equal one tab
set softtabstop=2                 " 2 spaces equal one tab
set shiftwidth=0                  " Use tabstop for auto-indentation
set expandtab                     " Use spaces instead of tabs
set backspace=indent,eol,start    " Backspacing over everything

set list                          " Show invisible characters
set listchars=tab:▸\ ,trail:␣

" +--------------+
" | Key mappings |
" +--------------+

let mapleader="ö"

nnoremap <F5> :make<CR>

" Map CTRL-J and CTRL-K to move through completion
inoremap <C-J> <C-N>
inoremap <C-K> <C-P>

" Map preview tag movements (similar to vim-unimpaired)
nnoremap ]p :ptnext<CR>
nnoremap [p :ptprev<CR>
nnoremap ]P :ptlast<CR>
nnoremap [P :ptfirst<CR>

" Plugin mappings
nnoremap <C-B> :YcmCompleter GoToDefinitionElseDeclaration<CR>

" +-----------------+
" | CTRL-P settings |
" +-----------------+

let g:ctrlp_custom_ignore='\.class$\|\vendor/bundle$|\tmp$|\.o$'
let g:ctrlp_by_filename=1 " Search only filename by default
let g:ctrlp_working_path_mode = 'rwa'

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" +--------------------+
" | syntastic settings |
" +--------------------+

let g:syntastic_enable_signs=0
let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1

let g:syntastic_tex_checkers=['chktex', 'lacheck']
let g:syntastic_ruby_checkers=['mri', 'rubocop']

" +------------------------+
" | YouCompleteMe settings |
" +------------------------+

let g:ycm_confirm_extra_conf=0         " Don't ask when opening ycm config file
let g:ycm_add_preview_to_completeopt=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'

" +------------------+
" | airline settings |
" +------------------+

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_linecolumn_prefix = '¶ '
let g:airline_branch_prefix = '⎇ '
let g:airline_paste_symbol = '∥'

let g:airline_theme='badwolf'

" +-------------------+
" | Other settings |
" +-------------------+
let g:LatexBox_latexmk_preview_continuously = 1
let delimitMate_expand_cr = 1

" Source local extra config file if it exists
" let s:extra_config = getcwd() .'/.vim_extra_conf.vim'
" if filereadable(s:extra_config)
"   execute 'source'. s:extra_config
" endif
