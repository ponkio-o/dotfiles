### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk

### Complement ###
zplugin load zsh-users/zsh-completions
fpath=(~/.zsh-completions $fpath)
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する

### PATH ###
#MySQL Client
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
# nodebrew
export PATH=$HOME/.nodebrew/node/v12.16.1/bin:$PATH
# krew
export PATH="${PATH}:${HOME}/.krew/bin"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/path.zsh.inc'; fi
# GOPATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload -U compinit; compinit
source ~/.zprofile

### completion ###
# kubectl completion
source <(kubectl completion zsh)
complete -o default -F __start_kubectl k
# aws cli
complete -C aws_completer aws
# gh (GitHub CLI)
eval "$(gh completion -s zsh)"
# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/completion.zsh.inc'; fi

### peco function ###
# kubectl config selector
function kx() {
    kcontext=$(kubectl config get-contexts  | peco --initial-index=1 --prompt='kubectl config use-context > ' |  sed -e 's/^\*//' | awk '{print $1}')
    if [ -n "$kcontext" ]; then
        kubectl config use-context $kcontext
    fi
}
# kubectl ns
function kns() {
    knamespace=$(kubens | peco)
    if [ -n "$knamespace" ]; then
        kubens $knamespace
    fi
}
# find directory
function find_cd() {
    cd "$(find . -type d | peco)"
}
# find file
function find_vim() {
    vim "$(find . -type f | peco)"
}
# zsh hisotry ( Ctrl + r )
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
# select Terraform version
function tfx() {
  tfenv use "$(tfenv list | peco)"
}
# git checkout
function gco() {
  git branch --sort=-authordate | grep -v -e '->' -e '*' | perl -pe 's/^\h+//g' | perl -pe 's#^remotes/origin/###' | perl -nle 'print if !$c{$_}++' | peco | xargs git checkout
}
