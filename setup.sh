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

# docker
mkdir -p $XDG_CONFIG_HOME/docker

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
ln -sf $DIR/git/config $XDG_CONFIG_HOME/git/config
ln -sf $DIR/git/config.user $XDG_CONFIG_HOME/git/config.user
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

## vim plugin setting files
NVIM_PLUGINS_DIR=$XDG_CONFIG_HOME/nvim/plugins
ln -sf $DIR/nvim/plugins/dein.toml $NVIM_PLUGINS_DIR/dein.toml
ln -sf $DIR/nvim/plugins/dein_lazy.toml $NVIM_PLUGINS_DIR/dein_lazy.toml
ln -sf $DIR/nvim/plugins/coc-vim.vim $NVIM_PLUGINS_DIR/coc-vim.vim
ln -sf $DIR/nvim/plugins/fugitive.vim $NVIM_PLUGINS_DIR/fugitive.vim
ln -sf $DIR/nvim/plugins/fzf.vim $NVIM_PLUGINS_DIR/fzf.vim
ln -sf $DIR/nvim/plugins/markdown-preview.vim $NVIM_PLUGINS_DIR/markdown-preview.vim
ln -sf $DIR/nvim/plugins/nerdtree.vim $NVIM_PLUGINS_DIR/nerdtree.vim
ln -sf $DIR/nvim/plugins/vim-goimports.vim $NVIM_PLUGINS_DIR/vim-goimports.vim
ln -sf $DIR/nvim/plugins/vim-terraform.vim $NVIM_PLUGINS_DIR/vim-terraform.vim

# script
ln -sf $DIR/script/sshx /usr/local/bin/sshx
ln -sf $DIR/script/get_battery_tmux /usr/local/bin/get_battery_tmux
ln -sf $DIR/script/get_ssid_tmux /usr/local/bin/get_ssid_tmux

# bin
cp $DIR/bin/realpath /usr/local/bin/realpath

# pet (snipet tool)
mkdir -p $XDG_CONFIG_HOME/pet
ln -sf $DIR/pet/config.toml $XDG_CONFIG_HOME/pet/config.toml
ln -sf $DIR/pet/snippet.toml $XDG_CONFIG_HOME/pet/snippet.toml
