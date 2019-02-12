#補完機能
autoload -U compinit
compinit
setopt nolistbeep
setopt magic_equal_subst

# プロンプト
PROMPT="%F{green}%c %f%# "

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

#cdでpushdする
setopt auto_pushd
#pushdの上限値
DIRSTACKSIZE=10
#同じディレクトリを重複しない
setopt pushd_ignore_dups
#dirs -v
alias dirs="dirs -v"

#alias
alias python="python3"
alias ll="ls -all"

#色
autoload colors
colors

# ls
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# lsがカラー表示になるようエイリアスを設定
case "${OSTYPE}" in
darwin*)
  # Mac
  alias ls="ls -GF"
  ;;
linux*)
  # Linux
  alias ls='ls -F --color'
  ;;
esac

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

# tmux自動起動
if [[ ! -n $TMUX ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  tmux attach-session -t "$ID"
fi

source ~/.alias
