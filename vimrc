call plug#begin('~/.vim/plugged')
Plug 'sjl/badwolf'

"Plug 'bling/vim-airline'
Plug 'fmoralesc/vim-tutor-mode'
"Plug 'tpope/vim-surround'
"Plug 'junegunn/vader.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'autoswap.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
"Plug 'benekastah/neomake'
"Plug 'cohama/lexima.vim'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-unimpaired'
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for': 'tex' }
Plug 'tpope/vim-liquid', { 'for': 'html' }
Plug 'matchit.zip'
"Plug 'AdvancedDiffOptions'
"Plug 'reedes/vim-wordy'
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-easytags'
Plug 'haya14busa/incsearch.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
"Plug 'KabbAmine/zeavim.vim'
Plug 'kopischke/vim-fetch'
Plug 'vim-scripts/diffchar.vim'
Plug 'ludovicchabant/vim-gutentags'

if has('python')
  Plug 'bbchung/clighter'
endif

if substitute(system('lsb_release -si'), "\n", "", "") == 'Arch' && has('python')
  function! BuildYCM(info)
    " info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status == 'installed' || a:info.force
      !./install.sh --clang-completer --system-libclang
    endif
  endfunction
  Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
end

call plug#end()

" +----------------+
" | Basic settings |
" +----------------+

filetype plugin indent on

syntax on                         " Turn on syntax highlighting
set encoding=utf-8                " UTF-8 encoding
set showcmd                       " Displays command in last line
set showmode                      " Displays mode in last line
set wildmenu                      " Displays tab completion above status line
set wildmode=longest:full,full    " Always show wildmenu
set cursorline                    " Highlight current line
set modelines=0                   " Disable modelines
set ttyfast                       " Faster redrawing in terminal
set visualbell                    " Visual bell instead of beeping
set background=dark

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
set number                        " ... but show absolute on current line

" -- Window management
set splitright                    " Create vertical splits on the right

" -- Indentation and tab handling
set tabstop=2                     " 2 spaces equal one tab
set shiftwidth=0                  " Use tabstop for auto-indentation
set softtabstop=-1                " Use shiftwidth
set expandtab                     " Use spaces instead of tabs
set backspace=indent,eol,start    " Backspacing over everything

if has('linebreak')
  set breakindent
endif

" -- Show invisible characters
set list
set listchars=tab:»\ ,trail:␣,extends:↲,precedes:↳,nbsp:·

" +--------------+
" | Key mappings |
" +--------------+

let mapleader = "ö"

nnoremap <F5> :make!<CR>
nnoremap <F6> :exec 'read !'.getline('.')<CR>

" Map CTRL-J and CTRL-K to move through completion
inoremap <C-J> <C-N>
inoremap <C-K> <C-P>

" Map CTRL-B to go to declaration
nnoremap <C-B> :YcmCompleter GoToDefinitionElseDeclaration<CR>

inoremap jk <ESC>
inoremap kj <ESC>
if has('nvim')
  tnoremap jk <C-\><C-N>
  tnoremap kj <C-\><C-N>
endif

" +----------------+
" | Theme settings |
" +----------------+

if &term == 'linux'
  silent! colorscheme darkblue
else
  silent! colorscheme badwolf
  highlight default link SneakPluginTarget EasyMotionTarget
  highlight default link SneakPluginScope EasyMotionShade
endif

highlight default SyntasticError ctermbg=196 guibg=#ff2c4b ctermfg=15 guifg=#f9f6f2 cterm=bold term=bold gui=bold
highlight default SyntasticWarning ctermbg=214 guibg=#ffa724 ctermfg=15 guifg=#f9f6f2 cterm=bold term=bold gui=bold

"highlight SyntasticError guibg=128

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
let g:syntastic_python_checkers = ['flake8']

let g:syntastic_cpp_compiler_options = '-std=c++11'

" +------------------------+
" | YouCompleteMe settings |
" +------------------------+

let g:ycm_confirm_extra_conf = 0         " Don't ask when opening ycm config file
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'

" +--------------------+
" | incsearch settings |
" +--------------------+

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
let g:incsearch#consistent_n_direction = 1
augroup incsearch-keymap
  autocmd!
  autocmd VimEnter * call s:incsearch_keymap()
augroup END
function! s:incsearch_keymap()
  IncSearchNoreMap <C-J> <Over>(incsearch-next)
  IncSearchNoreMap <C-K> <Over>(incsearch-prev)
  IncSearchNoreMap <C-U> <Over>(incsearch-scroll-f)
  IncSearchNoreMap <C-D> <Over>(incsearch-scroll-b)
endfunction

" +-------------------+
" | Other settings |
" +-------------------+

let delimitMate_expand_cr = 1
let g:easytags_suppress_report = 1

" Source local extra config file if it exists
" let s:extra_config = getcwd() .'/.vim_extra_conf.vim'
" if filereadable(s:extra_config)
"   execute 'source'. s:extra_config
" endif
