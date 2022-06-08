# emacs のキーバインドを利用する
bindkey -e

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# XDG Base Directory
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share

# zinit plugin
zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait'!0'; zinit load zsh-users/zsh-completions
zinit ice wait'!0'; zinit load zsh-users/zsh-autosuggestions

zmodload -i zsh/complist
autoload -Uz compinit && compinit
zstyle ':completion:*:default' menu select=2

# 補完時にhjklで選択
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

setopt auto_list           # 補完候補を一覧で表示する(d)
setopt auto_menu           # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed         # 補完候補をできるだけ詰めて表示する
setopt list_types          # 補完候補にファイルの種類も表示する
setopt nolistbeep          # 補完候補時にビープ音を鳴らさない
setopt magic_equal_subst   # 引数の補完を有効化
setopt correct             # スペルミスの補完
setopt auto_cd             # ディレクトリ名だけで cd
setopt ignore_eof          # ^D で終了しない
setopt rm_star_wait        # "rm *" の時に確認する
setopt share_history       # 複数のタブで履歴を共有
setopt nonomatch

# color
autoload colors
colors

# プロンプト
PROMPT="%F{green}%c %f%# "

# git の情報を右側に表示する
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

# GOPATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# aqua
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua.yaml

# aws cli completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
compinit
complete -C '/usr/local/bin/aws_completer' aws

## zsh history
HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt histignorealldups # 同じコマンドを重複して記録しない

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

# aws cli config selector
function awsx() {
    profile=$(cat ~/.aws/config | grep profile | sed -e 's/\[//g' -e 's/\]//g' | cut -f 2 -d " " | peco)
    export AWS_PROFILE=$profile
    aws whoami
}

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

function fzf-git-repo () {
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

source ~/.alias

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
