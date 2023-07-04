
:set number relativenumber
let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'morhetz/gruvbox'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

colorscheme gruvbox
set background=dark
let g:gruvbox_transparant_bg = 1

highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE

" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

