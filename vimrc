filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'sjl/badwolf'

Bundle 'tpope/vim-surround'
Bundle 'justinmk/vim-sneak'
Bundle 'autoswap.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'Raimondi/delimitMate'

if has('python') && (v:version > 703 || (v:version == 703 && has('patch584')))
  Bundle 'Valloric/YouCompleteMe'
end

" +----------------+
" | Basic settings |
" +----------------+

filetype plugin indent on

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
set completeopt=menuone           " Show completion menu even if only one match

" -- Side-/Statusbar
set ruler                         " Show current position in status bar
set laststatus=2                  " Always display status line
set noshowmode                    " Hide mode text below status line
set relativenumber                " Show relative line numbers

" -- Window management
set splitright                    " Create vertical splits on the right

" -- Indentation and tab handling
set tabstop=2                     " 2 spaces equal one tab
set softtabstop=2                 " 2 spaces equal one tab
set shiftwidth=0                  " Use tabstop for auto-indentation
set expandtab                     " Use spaces instead of tabs
set backspace=indent,eol,start    " Backspacing over everything

" -- Show invisible characters
set list
set listchars=tab:▸\ ,trail:␣

" +--------------+
" | Key mappings |
" +--------------+

let mapleader = "ö"

nnoremap <F5> :make!<CR>

" Map CTRL-J and CTRL-K to move through completion
inoremap <C-J> <C-N>
inoremap <C-K> <C-P>

" Map CTRL-B to go to declaration
nnoremap <C-B> :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Map f to Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

" Map t to Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" Map z as default Sneak
nmap z <Plug>Sneak_s
nmap Z <Plug>Sneak_S
xmap z <Plug>Sneak_s
xmap Z <Plug>Sneak_S
omap z <Plug>Sneak_s
omap Z <Plug>Sneak_S

" +----------------+
" | Theme settings |
" +----------------+

if &term == 'linux'
  silent! colorscheme darkblue
else
  silent! colorscheme badwolf
  hi link SneakPluginTarget EasyMotionTarget
  hi link SneakPluginScope EasyMotionShade
endif

hi link SyntasticError ErrorMsg
hi link SyntasticWarning WarningMsg

highlight CursorLine term=bold cterm=bold gui=bold

" Always show sign column
" autocmd BufEnter * sign define dummy
" autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

" +-----------------+
" | CTRL-P settings |
" +-----------------+

let g:ctrlp_custom_ignore = '\.class$\|\vendor/bundle$|\tmp$|\.o$'
let g:ctrlp_by_filename = 1 " Search only filename by default
let g:ctrlp_working_path_mode = 'rwa'

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" +--------------------+
" | Syntastic settings |
" +--------------------+

let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_signs = 0

let g:syntastic_tex_checkers = ['chktex', 'lacheck']
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

" +------------------------+
" | YouCompleteMe settings |
" +------------------------+

let g:ycm_confirm_extra_conf = 0         " Don't ask when opening ycm config file
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'

" +-------------------+
" | Other settings |
" +-------------------+

let delimitMate_expand_cr = 1

" Source local extra config file if it exists
" let s:extra_config = getcwd() .'/.vim_extra_conf.vim'
" if filereadable(s:extra_config)
"   execute 'source'. s:extra_config
" endif
