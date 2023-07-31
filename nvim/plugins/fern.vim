" default のキーマップを無効化
let g:fern#disable_default_mappings = 1

" Ctrl+n で toggle
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=30<CR>

" 隠しファイルをデフォルトで表示
let g:fern#default_hidden=1

" nerdfornt の有効化
let g:fern#renderer = "nerdfont"

function! FernInit() abort
  " https://github.com/lambdalisue/fern.vim/wiki/Tips#perform-expand-or-collapse-directory
  nmap <buffer><expr>
      \ <Plug>(fern-my-expand-or-collapse)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-collapse)",
      \   "\<Plug>(fern-action-expand)",
      \   "\<Plug>(fern-action-collapse)",
      \ )
  nmap <buffer><nowait> l <Plug>(fern-my-expand-or-collapse)

  " keymap
  nmap <buffer> s <Plug>(fern-action-open:side)
  nmap <buffer> i <Plug>(fern-action-open:split)
  nmap <buffer> <S-c> <Plug>(fern-action-new-dir)
  nmap <buffer> c <Plug>(fern-action-new-file)
  nmap <buffer> <S-i> <Plug>(fern-action-hidden:toggle)
  nmap <buffer> - <Plug>(fern-action-mark:toggle)
  vmap <buffer> - <Plug>(fern-action-mark:toggle)
  nmap <buffer> h <Plug>(fern-action-collapse)
  nmap <buffer> <S-u> <Plug>(fern-action-leave)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> <cr> <Plug>(fern-action-open-or-enter)
  nmap <buffer> <Enter> <Plug>(fern-action-open-or-expand)
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> <S-r> <Plug>(fern-action-reload)
  nmap <buffer> r <Plug>(fern-action-rename)
  nmap <buffer> y <Plug>(fern-action-yank)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> B <Plug>(fern-action-save-as-bookmark)
  nmap <buffer> <C-h> <C-w>h
  nmap <buffer> <C-l> <C-w>l
endfunction
augroup FernEvents
  autocmd!
  autocmd FileType fern setlocal norelativenumber | setlocal nonumber | call FernInit()
augroup END
