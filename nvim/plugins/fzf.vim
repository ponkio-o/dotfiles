let mapleader = "\<Space>"
" <Leader>f で :GFiles を起動
nnoremap <leader>f :Files<cr>
nnoremap <leader>l :Rg<cr>
nnoremap <leader>b :Buffers<cr>

" :Files で rg を利用して検索する際のオプション
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'

" Rg で オプションを渡せるようにする
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --no-heading --color=always --follow --glob "!.git/*" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
