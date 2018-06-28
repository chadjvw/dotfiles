set termguicolors
let g:airline_powerline_fonts = 1
let g:airline_theme='light'

set tabstop=4
set shiftwidth=4
set softtabstop=0 noexpandtab


call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sensible'

call plug#end()