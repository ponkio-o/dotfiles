let mapleader = "\<Space>"
" <Leader>f で :GFiles を起動
nnoremap <leader>f :Files<cr>
nnoremap <leader>l :Lines<cr>
nnoremap <leader>b :Buffers<cr>

" ripgrep を使用して検索する
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
