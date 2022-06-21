#!/bin/bash
set -euo pipefail

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# XDG Base Directory
mkdir -p $HOME/.config
mkdir -p $HOME/.cache
mkdir -p $HOME/.local/share

XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share

# aqua
mkdir -p $XDG_CONFIG_HOME/aquaproj-aqua
ln -sf $DIR/aqua/aqua.yaml $XDG_CONFIG_HOME/aquaproj-aqua/aqua.yaml

# zsh
ln -sf $DIR/shell/.alias $HOME/.alias
ln -sf $DIR/shell/.zprofile $HOME/.zprofile
ln -sf $DIR/shell/.zshenv $HOME/.zshenv
ln -sf $DIR/shell/.zshrc $HOME/.zshrc

# tmux
ln -sf $DIR/tmux/.tmux.conf $HOME/.tmux.conf

# peco
mkdir -p $XDG_CONFIG_HOME/peco
ln -sf $DIR/peco/config.json $XDG_CONFIG_HOME/peco/config.json

# aws cli
mkdir -p $HOME/.aws/cli
ln -sf $DIR/aws/cli/alias $HOME/.aws/cli/alias

# git
mkdir -p $XDG_CONFIG_HOME/git
ln -sf $DIR/git/.gitconfig $HOME/.gitconfig
ln -sf $DIR/git/.gitconfig.user $HOME/.gitconfig.user
ln -sf $DIR/git/ignore $XDG_CONFIG_HOME/git/ignore

# nvim
mkdir -p $XDG_CONFIG_HOME/nvim
mkdir -p $XDG_CONFIG_HOME/nvim/colors
mkdir -p $XDG_CONFIG_HOME/nvim/plugins
ln -sf $DIR/nvim/colors/molokai.vim $XDG_CONFIG_HOME/nvim/colors/molokai.vim
ln -sf $DIR/nvim/init.vim $XDG_CONFIG_HOME/nvim/init.vim
ln -sf $DIR/nvim/basic.vimrc $XDG_CONFIG_HOME/nvim/basic.vimrc
ln -sf $DIR/nvim/dein.vimrc $XDG_CONFIG_HOME/nvim/dein.vimrc
ln -sf $DIR/nvim/key_bind.vimrc $XDG_CONFIG_HOME/nvim/key_bind.vimrc
ln -sf $DIR/nvim/coc-settings.json $XDG_CONFIG_HOME/nvim/coc-settings.json

# script
ln -sf $DIR/script/sshx /usr/local/bin/sshx
ln -sf $DIR/script/get_battery_tmux /usr/local/bin/get_battery_tmux
ln -sf $DIR/script/get_ssid_tmux /usr/local/bin/get_ssid_tmux
