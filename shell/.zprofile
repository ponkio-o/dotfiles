# 補完候補時にビープ音を鳴らさない
setopt nolistbeep
# 引数の補完を有効化　
setopt magic_equal_subst
zstyle ':completion:*:default' menu select=1

# プロンプト
PROMPT="%F{green}%c %f%# "

# zsh history
HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt histignorealldups

# スペルミス
setopt correct
# ディレクトリ名でcd
setopt auto_cd
# beep off
setopt no_beep
# ^D で終了しない
setopt ignore_eof
# Check "rm *" command
setopt rm_star_wait
# curl no matches found 対策
setopt nonomatch
# 履歴を共有
setopt share_history


# cd で pushd する
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
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=32:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

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
 
setopt auto_list
setopt auto_menu
zstyle ':completion:*:default' menu select=1 
# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

source ~/.alias
