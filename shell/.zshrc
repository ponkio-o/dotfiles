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
# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload -U compinit; compinit
source ~/.zprofile

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/r0364/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/r0364/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/r0364/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/r0364/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# aws cli
complete -C aws_completer aws
