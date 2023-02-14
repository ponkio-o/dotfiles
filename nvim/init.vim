" iTerm2 を使用した時にカーソルが変更されるのを回避するための設定
set guicursor=

source $HOME/.config/nvim/dein.vimrc
source $HOME/.config/nvim/basic.vimrc
source $HOME/.config/nvim/key_bind.vimrc

" nvim/plugins の *.vim を読み込み
let splt = split(glob("~/.config/nvim/plugins/" . "*.vim"))

for file in splt
	execute 'source' file
endfor

" ファイルを開いた時にプロジェクトルートに移動する(プロジェクトルートから検索などを行いたいため)
" {{{ ensure_git_root
function! s:ensure_git_root() abort
  let cmd = 'git rev-parse --show-superproject-working-tree --show-toplevel 2>/dev/null | head -1'
  let root = system(cmd)->trim()->expand()
  if isdirectory(root) && root != getcwd()
    execute 'cd' root
  endif
endfunction
autocmd VimEnter * ++once call s:ensure_git_root()
" }}}

" :CocInstall で入れる extensions
let g:coc_global_extensions = [
      \'coc-go',
      \'coc-json',
      \'coc-yaml',
      \'coc-tsserver',
      \'coc-phpls',
      \'coc-graphql'
\]
