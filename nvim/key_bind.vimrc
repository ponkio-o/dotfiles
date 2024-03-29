" Emacs like
map <silent> <C-a> <Esc>0<Insert>
map <silent> <C-e> <Esc>$a

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Leader
let mapleader = "\<Space>"

" Basic
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>wq :wq<cr>
nnoremap <leader>wqq :wq!<cr>
nnoremap <leader>qq :q!<cr>
nnoremap <leader>r :source ~/.vimrc<cr>
