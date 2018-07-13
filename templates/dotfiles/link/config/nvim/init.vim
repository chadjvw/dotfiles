set termguicolors
set tabstop=2
set shiftwidth=4
set softtabstop=0 noexpandtab

let g:airline_powerline_fonts = 1
let g:airline_theme='light'

call plug#begin('/home/{{ username }}/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sensible'

call plug#end()