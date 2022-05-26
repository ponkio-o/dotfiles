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

## zsh history
HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt histignorealldups # 同じコマンドを重複して記録しない

source ~/.alias
