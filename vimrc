if empty(glob('~/.dotfiles/vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.dotfiles/vim/plugged')
Plug 'sjl/badwolf'

Plug 'junegunn/vim-peekaboo'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wellle/targets.vim'
Plug 'kopischke/vim-fetch'
Plug 'tpope/vim-unimpaired'

if has('nvim')
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  Plug 'roxma/nvim-completion-manager'
  Plug 'parsonsmatt/intero-neovim'
  Plug 'w0rp/ale'
endif

" Syntax plugins
Plug 'leafgarland/typescript-vim'
Plug 'tasn/vim-tsx'

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
set mouse=
set hidden
set shortmess+=c

set termguicolors

if has('nvim')
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'
endif

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

if executable('rg')
  set grepprg=rg\ --vimgrep
endif

" -- Spell checking
set spelllang=en_us,de
set spellfile=~/.vim/spell/fwalch.utf-8.add

" -- Completion
set completeopt=menuone,preview   " Show completion menu even if only one match
set complete=.,w,b,u,t,i,kspell

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

if exists('+breakindent')
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
"nnoremap <F6> :exec 'read !'.getline('.')<CR>
" Execute visual selection in split terminal
vnoremap <F6> y<c-w>wpA<cr><c-\><c-n><c-w>pgv
nnoremap <F6> yy<c-w>wpA<cr><c-\><c-n><c-w>p

" Map CTRL-J and CTRL-K to move through completion
inoremap <C-J> <C-N>
inoremap <C-K> <C-P>

" Map ESC ESC to exit terminal mode
if has('nvim')
  tnoremap <esc><esc> <C-\><C-n>
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

highlight CursorLine term=bold cterm=bold gui=bold

" +-----------------+
" | CTRL-P settings |
" +-----------------+

let g:ctrlp_custom_ignore = '\v[\/]\.git$'
let g:ctrlp_by_filename = 1 " Search only filename by default
let g:ctrlp_working_path_mode = 'rwa'
let g:ctrlp_root_markers = ['.repo', '.dotfiles', '.git']
let g:ctrlp_working_path_mode = 0

if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" +-----------------+
" | Intero settings |
" +-----------------+

let g:intero_use_neomake = 0

augroup interoMappings
  au!
  au FileType haskell nnoremap <buffer><silent> <leader>io :InteroOpen<CR>
  au FileType haskell nnoremap <buffer><silent> <leader>ik :InteroKill<CR>

  au FileType haskell map <buffer><silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <buffer><silent> <leader>T <Plug>InteroType
augroup end

" +--------------+
" | ALE settings |
" +--------------+

let g:ale_linters = {
\  'cpp': ['clang-tidy'],
\  'haskell': ['hlint', 'stack-build'],
\}

let g:ale_c_clangtidy_build_dir = 'build'

" Use config from .clang-tidy
let g:ale_c_clangtidy_checks = []
let g:ale_cpp_clangtidy_checks = []

" +--------------+
" | LSP settings |
" +--------------+

let g:LanguageClient_serverCommands = {
    \ 'c': ['cquery'],
    \ 'cpp': ['cquery'],
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'haskell': ['hie', '--lsp'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'typescript.tsx': ['javascript-typescript-stdio'],
    \ }

let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = expand('$HOME/.dotfiles/vim/lc-settings.json')

augroup LspMappings
  au!
  au FileType c,cpp,rust,haskell,javascript,javascript.jsx,typescript,typescript.tsx nnoremap <buffer><silent> K :call LanguageClient_textDocument_hover()<CR>
  au FileType c,cpp,rust,haskell,javascript,javascript.jsx,typescript,typescript.tsx nnoremap <buffer><silent> gd :call LanguageClient_textDocument_definition()<CR>
  au FileType c,cpp,rust,haskell,javascript,javascript.jsx,typescript,typescript.tsx nnoremap <buffer><silent> <F2> :call LanguageClient_textDocument_rename()<CR>
  au FileType c,cpp,rust,haskell,javascript,javascript.jsx,typescript,typescript.tsx nnoremap <buffer><silent> <F7> :call LanguageClient_textDocument_references()<CR>
  au FileType rust,haskell,javascript,javascript.jsx,typescript,typescript.tsx setlocal formatexpr=LanguageClient_textDocument_rangeFormatting()
augroup end

" +-------------------+
" | Other settings |
" +-------------------+

let g:deoplete#enable_at_startup = 1

" Source local extra config file if it exists
" let s:extra_config = getcwd() .'/.vim_extra_conf.vim'
" if filereadable(s:extra_config)
"   execute 'source'. s:extra_config
" endif
