" Leader for vim-go commands
let mapleader = "\<Space>"
" <leader>s で定義を水平分割
au FileType go nmap <leader>s <Plug>(go-def-split)
" <leader>s で定義を垂直分割
au FileType go nmap <leader>v <Plug>(go-def-vertical)
" <C-j> で定義箇所にジャンプ (<C-o> で戻る)
au FileType go nmap <C-j> <Plug>(go-def)
" ドキュメントをブラウザで開く
:command Godoc GoDocBrowser
