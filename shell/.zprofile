#補完機能
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
autoload -U compinit
setopt nolistbeep
setopt magic_equal_subst

#kubectl complete
source <(kubectl completion zsh)

# プロンプト
PROMPT="%F{green}%c %f%# "

# zsh history
export HISTSIZE=1000
export SAVEHIST=100000
setopt histignorealldups

#スペルミス
setopt correct
#ディレクトリ名でcd
setopt auto_cd
#beep off
setopt no_beep
#^Dで終了しない
setopt ignore_eof
#Check "rm *" command
setopt rm_star_wait
#curl no matches found対策
setopt nonomatch

#cdでpushdする
setopt auto_pushd
#pushdの上限値
DIRSTACKSIZE=10
#同じディレクトリを重複しない
setopt pushd_ignore_dups

# color
autoload colors
colors

# ls
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# git設定
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

#peco function
function find_cd() {
    cd "$(find . -type d | peco)"
}

function find_vim() {
    vim "$(find . -type f | peco)"
}

function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

source ~/.alias
