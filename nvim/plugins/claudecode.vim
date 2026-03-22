" Claude のウインドウを Ctrl-w で操作できるようにする
autocmd TermOpen * if expand('<afile>') =~ 'claude' | tnoremap <buffer> <C-w> <C-\><C-n><C-w> | endif

nnoremap <silent> <leader>ac <cmd>ClaudeCode<cr>
nnoremap <silent> <leader>af <cmd>ClaudeCodeFocus<cr>
nnoremap <silent> <leader>ar <cmd>ClaudeCode --resume<cr>
nnoremap <silent> <leader>aC <cmd>ClaudeCode --continue<cr>
nnoremap <silent> <leader>am <cmd>ClaudeCodeSelectModel<cr>
nnoremap <silent> <leader>ab <cmd>ClaudeCodeAdd %<cr>
vnoremap <silent> <leader>as <cmd>ClaudeCodeSend<cr>
nnoremap <silent> <leader>aa <cmd>ClaudeCodeDiffAccept<cr>
nnoremap <silent> <leader>ad <cmd>ClaudeCodeDiffDeny<cr>
