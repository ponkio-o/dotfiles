" Ctrl+n で toggle
map <C-n> :NERDTreeToggle<CR>

" 自動で折りたたまないようにする
let g:vim_markdown_folding_disabled=1
let g:previm_enable_realtime = 1

" 隠しファイルをデフォルトで表示する
let NERDTreeShowHidden = 1

" 残っている tab が NERDTree だけの場合は終了
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" 残っている window が NERDTree だけの場合は終了
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
