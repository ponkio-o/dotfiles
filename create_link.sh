#!/bin/bash

# create directory
if [ ! -d ~/.vim/colors ]; then
    echo "create ~/.vim/colors"
    mkdir -p ~/.vim/colors
else
    echo "~/.vim/colors exist"
fi

if [ ! -d ~/.vim/bundle ]; then
    echo "create ~/.vim/bundle"
    mkdir -p ~/.vim/bundle
else
    echo "~/.vim/bundle exist"
fi

if [ ! -d ~/.zsh-completions ]; then
    echo "create ~/.zsh-completions"
    mkdir ~/.zsh-completions
else
    echo "~/.zsh-completions exist"
fi

if [ ! -d ~/.peco ]; then
    echo "create ~/.peco"
    mkdir ~/.peco
else
    echo "~/.peco exist"
fi

# create symbolic link (zsh)
ln -sf $(pwd)/shell/.alias ~/.alias
ln -sf $(pwd)/shell/.zprofile ~/.zprofile
ln -sf $(pwd)/shell/.zshenv ~/.zshenv
ln -sf $(pwd)/shell/.zshrc ~/.zshrc
ln -nsf $(pwd)/shell/zsh-completions/* ~/.zsh-completions/

# create symbolic link (tmux)
ln -sf $(pwd)/tmux/.tmux.conf ~/.tmux.conf

# create symbolic link (vim)
ln -sf $(pwd)/vim/.vimrc ~/.vimrc
ln -sf $(pwd)/vim/colors/molokai.vim ~/.vim/colors/molokai.vim

# create symbolic link (peco)
ln -sf $(pwd)/peco/config.json ~/.peco/config.json

# installation tmux script
cp $(pwd)/tmux-scripts/get_battery_tmux /usr/local/bin/
chmod +x /usr/local/bin/get_battery_tmux
cp $(pwd)/tmux-scripts/get_ssid_tmux /usr/local/bin/
chmod +x /usr/local/bin/get_ssid_tmux

# installation vim plugin
cp -R -fp $(pwd)/vim-plugins/* ~/.vim/bundle

type vim > /dev/null 2>&1
if [ $? -eq 0 ] ; then
    :
else                   # コマンドが存在しなければ
    echo "vim not found" >&2
    exit 1
fi

if [ -e ~/.vim/bundle ]; then
    echo "installation vim plugin? [y/N]"
    read ANS
    case $ANS in
        [Yy]* )
            type vim > /dev/null 2>&1
            if [ $? -eq 0 ] ; then
                :
            else 
                echo "vim not found" >&2
                exit 1
            fi
            echo "processing installation..."
            vim +PluginInstall +qall
            ;;
        * )
            echo "suspend installation"
            exit 1
            ;;
    esac
else
    echo "not found vim plugins"
fi
