" kat0h/dps-bufpreview.vim settings
autocmd BufRead,BufNewFile *.mkd  set filetype=markdown
autocmd BufRead,BufNewFile *.md  set filetype=markdown
nnoremap <silent> <C-p> ::PreviewMarkdwon<CR>
