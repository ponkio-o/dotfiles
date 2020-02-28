### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin installer's chunk
zplugin load zsh-users/zsh-completions
fpath=(~/.zsh-completions/src $fpath)
autoload -U compinit; compinit
