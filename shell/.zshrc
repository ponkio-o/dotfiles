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

# docker
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker

# GOPATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# krew (kubectl plugins)
export PATH="${PATH}:${HOME}/.krew/bin"

# krew (kubectl plugins)
export PATH="${PATH}:${HOME}/.docker/cli-plugins"

# aqua
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua.yaml

# dotnet
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

# aws cli completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
compinit
complete -C 'aws_completer' aws

# fnm (Node.js version manager)
eval "$(fnm env --use-on-cd)"

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# tfenv
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  TFENV_ARCH="amd64"
elif [ "$ARCH" = "arm64" ]; then
  TFENV_ARCH="arm64"
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi
export TFENV_ARCH

## zsh history
HISTFILE=~/.zsh_history
export HISTSIZE=5000
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
    profile=$(cat ~/.aws/config | grep '\[profile' | sed -e 's/\[//g' -e 's/\]//g' | cut -f 2 -d " " | peco)
    export AWS_PROFILE=$profile
    aws whoami
}

# git fetch fork
function git-pull-upstream() {
  REPO=$(git remote get-url origin | sed -E 's%.+github.com/(.*).git$%\1%')
  echo "Syncing ${REPO}...\\n"
  gh repo sync ${REPO} && git pull
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

# kubectl rollout deploy selector
function krrdx() {
    deployment=$(kubectl get deploy -o json | jq -r .items[].metadata.name | peco)
    kubectl rollout restart deploy $deployment
}

# git checkout
function gco() {
  git branch --sort=-authordate | grep -v -e '->' -e '*' | perl -pe 's/^\h+//g' | perl -pe 's#^remotes/origin/###' | perl -nle 'print if !$c{$_}++' | peco | xargs git checkout
}

# github repository open
function open-git-remote() {
  git rev-parse --git-dir >/dev/null 2>&1
  if [[ $? == 0 ]]; then
    git config --get remote.origin.url | sed -re 's#git@(.*.(jp|com)):#https://\1/#g' -e 's#ssh://git@#https://#g' -e 's#git@#https://#g' -e 's#github.com:#github.com/#g' | xargs open
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

function peco-git-wt () {
    local selected=$(git wt | tail -n +2 | peco)
    if [ -n "$selected" ]; then
        local wt=$(git wt $(echo "$selected" | awk '{print $(NF-1)}'))
        if [ -n "$wt" ]; then
            BUFFER="cd ${wt}"
            zle accept-line
        fi
    fi
    zle clear-screen
    zle reset-prompt
}
zle -N peco-git-wt
bindkey '^[' peco-git-wt

function gcloud-activate() {
  name="$1"
  project="$2"
  echo "gcloud config configurations activate \"${name}\""
  gcloud config configurations activate "${name}"
}
function gx-complete() {
  _values $(gcloud config configurations list | awk '{print $1}')
}
function gx() {
  name="$1"
  if [ -z "$name" ]; then
    line=$(gcloud config configurations list | tail -n +2 | peco)
    name=$(echo "${line}" | awk '{print $1}')
  else
    line=$(gcloud config configurations list | grep "$name")
  fi
  project=$(echo "${line}" | awk '{print $4}')
  gcloud-activate "${name}" "${project}"
}
compdef gx-complete gx

# dops
# https://github.com/Mikescher/better-docker-ps#usage-as-drop-in-replacement
docker() {
  case $1 in
    ps)
      shift
      command dops "$@"
      ;;
    *)
      command docker "$@";;
  esac
}

# tunnel command config selector
function tnlx() {
    CONFIG_DIR=~/.config/sshtunnel
    ls $CONFIG_DIR | peco | xargs printf "$CONFIG_DIR/%s" | xargs tunnel -c
}

source ~/.alias

# get remote branch
function gpr() {
    git fetch origin
    BRANCH=$(git branch -r --no-merged | peco | sed -e 's/ //g' | sed -e 's/^origin\///g')
    git fetch origin $BRANCH && git switch $BRANCH
}

# for 1Password plugin
# https://developer.1password.com/docs/cli/shell-plugins/aws/
PLUGIN_FILE="$HOME/.config/op/plugins.sh"
if [ -e $PLUGIN_FILE ]; then
    source $HOME/.config/op/plugins.sh
fi

# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd() {
    \builtin pwd -L
}

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd() {
    # shellcheck disable=SC2164
    \builtin cd -- "$@"
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
function __zoxide_hook() {
    # shellcheck disable=SC2312
    \command zoxide add -- "$(__zoxide_pwd)"
}

# Initialize hook.
# shellcheck disable=SC2154
if [[ ${precmd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]] && [[ ${chpwd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]]; then
    chpwd_functions+=(__zoxide_hook)
fi

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

__zoxide_z_prefix='z#'

# Jump to a directory using only keywords.
function __zoxide_z() {
    # shellcheck disable=SC2199
    if [[ "$#" -eq 0 ]]; then
        __zoxide_cd ~
    elif [[ "$#" -eq 1 ]] && { [[ -d "$1" ]] || [[ "$1" = '-' ]] || [[ "$1" =~ ^[-+][0-9]$ ]]; }; then
        __zoxide_cd "$1"
    elif [[ "$@[-1]" == "${__zoxide_z_prefix}"?* ]]; then
        # shellcheck disable=SC2124
        \builtin local result="${@[-1]}"
        __zoxide_cd "${result:${#__zoxide_z_prefix}}"
    else
        \builtin local result
        # shellcheck disable=SC2312
        result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" &&
            __zoxide_cd "${result}"
    fi
}

# Jump to a directory using interactive search.
function __zoxide_zi() {
    \builtin local result
    result="$(\command zoxide query --interactive -- "$@")" && __zoxide_cd "${result}"
}

# Completions.
if [[ -o zle ]]; then
    function __zoxide_z_complete() {
        # Only show completions when the cursor is at the end of the line.
        # shellcheck disable=SC2154
        [[ "${#words[@]}" -eq "${CURRENT}" ]] || return 0

        if [[ "${#words[@]}" -eq 2 ]]; then
            _files -/
        elif [[ "${words[-1]}" == '' ]] && [[ "${words[-2]}" != "${__zoxide_z_prefix}"?* ]]; then
            \builtin local result
            # shellcheck disable=SC2086,SC2312
            if result="$(\command zoxide query --exclude "$(__zoxide_pwd)" --interactive -- ${words[2,-1]})"; then
                result="${__zoxide_z_prefix}${result}"
                # shellcheck disable=SC2296
                compadd -Q "${(q-)result}"
            fi
            \builtin printf '\e[5n'
        fi
        return 0
    }

    \builtin bindkey '\e[0n' 'reset-prompt'
    [[ "${+functions[compdef]}" -ne 0 ]] && \compdef __zoxide_z_complete __zoxide_z
fi

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

\builtin alias wd=__zoxide_z
\builtin alias wdi=__zoxide_zi

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually ~/.zshrc):
#
# eval "$(zoxide init zsh)"

# for pipx
export PATH="$PATH:/Users/$USER/.local/bin"

# for deno
export PATH="/Users/$USER/.deno/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/bin/google-cloud-sdk/completion.zsh.inc'; fi

# for k1LoW/git-wt
eval "$(git wt --init zsh --nocd)"
