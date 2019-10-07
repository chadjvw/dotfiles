if &compatible
  set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=/home/{{ username }}/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/home/{{ username }}/.cache/dein')
  call dein#begin('/home/{{ username }}/.cache/dein')

  call dein#add('/home/{{ username }}/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('tpope/vim-sensible')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-eunuch')
  " call dein#add('vim-syntastic/syntastic')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('junegunn/fzf')
  call dein#add('junegunn/fzf.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('tpope/vim-surround')
  call dein#add('dense-analysis/ale')
  call dein#add('itchyny/lightline.vim')
  call dein#add('maximbaz/lightline-ale')
  " call dein#add('sheerun/vim-polyglot')
  call dein#add('dracula/vim')
  call dein#add('haishanh/night-owl.vim')
  call dein#add('drewtempelmeyer/palenight.vim')
  call dein#add('challenger-deep-theme/vim')
  call dein#add('Rigellute/rigel')

  " if !has('nvim')
  "   call dein#add('roxma/nvim-yarp')
  "   call dein#add('roxma/vim-hug-neovim-rpc')
  " endif

  call dein#end()
  call dein#save_state()
endif

" 
" Colors 
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" lightline 
set laststatus=2
set noshowmode
" let g:lightline = {'colorscheme': 'palenight' }
" let g:lightline = {'colorscheme': 'challenger_deep' }
let g:rigel_lightline = 1
let g:lightline = { 'colorscheme': 'rigel' }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }

syntax enable  " enable syntax processing  

set background=dark
" colorscheme palenight
" colorscheme challenger_deep
colorscheme rigel

" Italics for my favorite color scheme
let g:palenight_terminal_italics=1

if (has("termguicolors"))
 set termguicolors
endif
" 
" Misc 
set backspace=indent,eol,start
let g:vimwiki_list = [{'path': '~/.wiki/'}]
set clipboard=unnamed
set title
" 
" Spaces & Tabs 
set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set shiftwidth=4
set modelines=1
filetype indent on
filetype plugin on
set autoindent
" 
" UI Layout 
set number              " show line numbers'
set showcmd             " show command in bottom bar
set nocursorline        " highlight current line
set wildmenu
set lazyredraw
set showmatch           " higlight matching parenthesis
set fillchars+=vert:┃
" 
" Searching 
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" 
" Folding 
"=== folding ===
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <space> za
set foldlevelstart=10   " start with fold level of 1
" 
" Line Shortcuts 
nnoremap j gj
nnoremap k gk
nnoremap gV `[v`]
" 

" Syntastic 
" let g:syntastic_python_flake8_args='--ignore=E501'
" let g:syntastic_ignore_files = ['.java$']
" let g:syntastic_python_python_exec = 'python3'

" ALE
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'vue': ['eslint'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\}

" Do not lint or fix minified files.
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 5
" keep the sign gutter open
let g:ale_sign_column_always = 1

" 
" AutoGroups 
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh,*.js,*.ts,*.yml,*.yaml setlocal tabstop=2
    autocmd BufEnter *.sh,*.js,*.ts,*.yml,*.yaml setlocal shiftwidth=2
    autocmd BufEnter *.sh,*.js,*.ts,*.yml,*.yaml setlocal softtabstop=2
    autocmd BufEnter *.py setlocal tabstop=4
    autocmd BufEnter *.md setlocal ft=markdown
    autocmd BufEnter *.go setlocal noexpandtab
    autocmd BufEnter *.avsc setlocal ft=json
augroup END
"
" NerdTree
" open a NERDTree automatically when vim starts up
" autocmd vimenter * NERDTree
" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" open NERDTree automatically when vim starts up on opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 
" Backups 
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" 
" 
" vim:foldmethod=marker:foldlevel=0
