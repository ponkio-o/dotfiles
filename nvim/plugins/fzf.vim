let mapleader = "\<Space>"
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :GFiles<cr>
nnoremap <leader>l :Rg<cr>
nnoremap <leader>b :Buffers<cr>

" :Files で rg を利用して検索する際のオプション
" --files: ファイルの列挙
" --follow: シンボリックリンクを追跡
" --no-ignore-vcs: .gitignore を考慮しない
" --glob: GLOB 形式でフィルタ
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --no-ignore-vcs --glob "!.git/*"'

" Rg で オプションを渡せるようにする
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --no-heading --color=always --follow --glob "!.git/*" -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Git プロジェクト配下の時にはプロジェクトルートからファイル探索する
" (それ以外はカレントディレクトリから探索)
function! s:find_files()
    let git_dir = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    if git_dir != ''
        execute 'Files' git_dir
    else
        execute 'Files'
    endif
endfunction
command! ProjectFiles execute s:find_files()
nnoremap <leader>p :ProjectFiles<CR>
