# My Dotfiles

## Install
brew
```bash
$ brew bundle
```

zsh
```bash
$ sh -c "$(curl -fsSL https://git.io/zinit-install)"
$ source ~/.zshrc
$ zinit self-update
```

tmux plugin manager
```bash
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

`gh` extension
```
$ gh extension install kawarimidoll/gh-q
```

nvim plugin
```bash
$ mkdir -p $HOME/.cache/dein
$ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
$ sh ./installer.sh ~/.cache/dein
```

run setup script
```bash
$ ./setup.sh
```
