bindkey -e
### zinit ###
source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### zinit plugin ###
zinit load zsh-users/zsh-syntax-highlighting
zinit ice wait'!0'; zinit load zsh-users/zsh-completions
zinit ice wait'!0'; zinit load zsh-users/zsh-autosuggestions

### fpath ###
zstyle ':completion:*:*:git:*' script ~/.zsh-completions/git-completion.bash
fpath=(~/.zsh-completions/src $fpath)

# Key bind
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
# MySQL Client
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
# krew
export PATH="${PATH}:${HOME}/.krew/bin"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/path.zsh.inc'; fi
# GOPATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
# VMWare OVF Tool
export OVF_TOOL="/Applications/VMware OVF Tool"
export PATH=$PATH:$OVF_TOOL

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
source ~/.zprofile

# direnv
export EDITOR=vim
eval "$(direnv hook zsh)"

### completion ###
# kubectl completion
kubectl() {
  unfunction "$0"
  source <(kubectl completion zsh)
  $0 "$@"
}
# gh (GitHub CLI)
eval "$(gh completion -s zsh)"
# gcloud
if [ -f '/usr/local/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google-cloud-sdk/completion.zsh.inc'; fi
# aws cli
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
compinit
complete -C '/usr/local/bin/aws_completer' aws

### peco function ###
# kubectl config selector
function kx() {
    kcontext=$(kubectl config get-contexts --no-headers=true | peco --initial-index=1 --prompt='kubectl config use-context > ' |  sed -e 's/^\*//' | awk '{print $1}')
    if [ -n "$kcontext" ]; then
        kubectl config use-context $kcontext
    fi
}
# kubectl namespace selector
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
  if (($+zle_bracketed_paste)); then
        print $zle_bracketed_paste[2]
  fi
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
  CURSOR=$#BUFFER
  zle reset-prompt
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

# github repository open
function open-git-remote() {
  git rev-parse --git-dir >/dev/null 2>&1
  if [[ $? == 0 ]]; then
    git config --get remote.origin.url | sed -e 's#ssh://git@#https://#g' -e 's#git@#https://#g' -e 's#github.com:#github.com/#g' | xargs open
  else
    echo ".git not found.\n"
  fi
}

zle -N open-git-remote
bindkey '^o' open-git-remote

alias agg="_agAndVim"
function _agAndVim() {
    if [ -z "$1" ]; then
        echo 'Usage: agg PATTERN'
        return 0
    fi
    result=`ag $1 | fzf`
    line=`echo "$result" | awk -F ':' '{print $2}'`
    file=`echo "$result" | awk -F ':' '{print $1}'`
    if [ -n "$file" ]; then
        vim $file +$line
    fi
}

fzf-git-repo () {
    local repo=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        BUFFER="cd ${repo}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-git-repo
bindkey '^]' fzf-git-repo
