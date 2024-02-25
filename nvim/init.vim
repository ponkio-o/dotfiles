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

" :CocInstall で入れる extensions
let g:coc_global_extensions = [
      \'coc-go',
      \'coc-json',
      \'coc-yaml',
      \'coc-tsserver',
      \'coc-prettier',
      \'coc-phpls',
      \'coc-snippets',
      \'coc-toml'
\]
