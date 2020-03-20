#!/bin/sh
if [ ! -e {~/.vim/colors} ]; then
    mkdir -p ~/.vim/colors
fi

if [ ! -e {~/.zsh-completions} ]; then
    mkdir ~/.zsh-completions
fi

if [ ! -e {~/.peco} ]; then
    mkdir ~/.peco
fi

ln -sf $(pwd)/shell/.alias ~/.alias
ln -sf $(pwd)/shell/.zprofile ~/.zprofile
ln -sf $(pwd)/shell/.zshenv ~/.zshenv
ln -sf $(pwd)/shell/.zshrc ~/.zshrc
ln -sf $(pwd)/tmux/.tmux.conf ~/.tmux.conf
ln -sf $(pwd)/vim/.vimrc ~/.vimrc
ln -sf $(pwd)/vim/colors/molokai.vim ~/.vim/colors/molokai.vim
ln -nsf $(pwd)/shell/zsh-completions ~/.zsh-completions
ln -sf $(pwd)/peco/config.json ~/.peco/config.json

cp $(pwd)/tmux-scripts/get_battery_tmux /usr/local/bin/
chmod +x /usr/local/bin/get_battery_tmux
cp $(pwd)/tmux-scripts/get_ssid_tmux /usr/local/bin/
chmod +x /usr/local/bin/get_ssid_tmux

