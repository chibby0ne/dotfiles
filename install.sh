#!/bin/bash

# installing vim and tmux
echo "================="
echo "Installing vim and tmux"
echo "================="
sudo apt-get update && sudo apt-get install vim tmux -y
echo -e "Vim and tmux installed!\n"

echo "================="
echo "Setting symlinks"
echo "================="
echo "Setting bashrc"
ln -s $(pwd)/bashrc ~/.bashrc
echo "Setting vimrc"
ln -s $(pwd)/vimrc ~/.vimrc
echo -e "Setting tmux.conf"
ln -s $(pwd)/tmux.conf ~/.tmux.conf
echo -e "Setting gitconfig\n"
ln -s $(pwd)/gitconfig ~/.gitconfig

echo "================="
echo "Setting up .tmux.conf.dev" 
echo "================="
echo "Creating ~/.tmux"
mkdir ~/.tmux
echo -e "Setting symlink\n"
ln -s $(pwd)/tmux/tmux.conf.dev ~/.tmux/.tmux.conf.dev 

echo "================="
echo "Installing Vundle" 
echo "================="
echo "Creating ~/.vim/bundle"
mkdir -p ~/.vim/bundle
echo "Cloning Vundle"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo -e "Vundle installed!\n"

echo "NOTE: Remember to open vim and run :PluginInstall in order to \
install the rest of the plugins. Also don't forget to use the patches once \
the plugins are installed"
