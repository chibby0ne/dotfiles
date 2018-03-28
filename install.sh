#!/bin/bash

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "================="
echo "Installing several very useful packages (needs sudo)"
echo "================="
distro=$(cat /etc/*-release | grep ^NAME= | sed 's/NAME="\(.*\)"/\1/g')
if [[ "$distro" == "Arch Linux" ]]; then
    sudo pacman -Syyu --noconfirm && sudo pacman -S vim tmux dmidecode ruby rubygems docker curl powerline-fonts ttf-dejavu go noto-fonts --noconfirm
elif [[ "$distro" == "Ubuntu" ]]; then
    sudo apt-get update && sudo apt-get install vim tmux dmidecode ruby-dev -y
    # Taken from dockers docs: https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository
    sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install docker-ce -y
fi
echo -e "Vim and tmux installed!\n"

echo "================="
echo "Setting symlinks"
echo "================="
echo "Setting bashrc"
ln -sf ${SCRIPT_DIR}/bashrc ~/.bashrc
echo "Setting zshrc"
ln -sf ${SCRIPT_DIR}/zshrc ~/.zshrc
echo "Setting Xdefaults"
ln -sf ${SCRIPT_DIR}/Xdefaults ~/.Xdefaults
echo "Setting .config/i3/config"
mkdir -p ~/.config/i3 && ln -sf ${SCRIPT_DIR}/i3/config ~/.config/i3/config
echo "i3 lockscreen picture"
mkdir -p ~/Pictures && ln -sf ${SCRIPT_DIR}/i3/marscolonization.png ~/Pictures/marscolonization.png
echo "Setting vimrc"
ln -sf ${SCRIPT_DIR}/vimrc ~/.vimrc
echo -e "Setting tmux.conf"
ln -sf ${SCRIPT_DIR}/tmux.conf ~/.tmux.conf
echo -e "Setting gitconfig"
ln -sf ${SCRIPT_DIR}/gitconfig ~/.gitconfig
echo -e "Setting global tern-config (required for js completion in vim with YCM)"
ln -sf ${SCRIPT_DIR}/tern-config ~/.tern-config
echo -e "Setting profile\n"
ln -sf ${SCRIPT_DIR}/profile ~/.profile


# Find computer model to see if the scripts for handling fn keys are required
laptop_model=$(sudo dmidecode | grep 'Version: ' | head -n 1 | sed 's/Version: \(.*\)/\1/g' | sed 's/[[:blank:]]//g')

# Copy the scripts for making Fn keys work in Arch Linux for Asus Zenbook UX330 Notebook
if [[ "$distro" == "Arch Linux" && "$laptop_model" == "UX330UAK.301" ]]; then
    echo "================="
    echo "Setting symlinks and binaries for handling function keys in Asus Zenbook Laptop (needs sudo)"
    echo "================="
    echo "Setting symlink kb-light.py (Keyboard Backlight control)"
    ln -sf ${SCRIPT_DIR}/i3/kb-light.py ~/.config/i3/kb-light.py
    echo "Setting symlink toogletouchpad.sh (Toogle touchpad control)"
    ln -sf ${SCRIPT_DIR}/i3/toogletouchpad.sh ~/.config/i3/toogletouchpad.sh
    echo "Setting adjust_brightness (Screen Brightness control)"
    sudo cp ${SCRIPT_DIR}/i3/adjust_brightness /usr/local/bin/
fi

echo "================="
echo "Setting up .tmux.conf.dev"
echo "================="
echo "Creating ~/.tmux"
mkdir ~/.tmux
echo -e "Setting symlink\n"
ln -sf ${SCRIPT_DIR}/tmux/tmux.conf.dev ~/.tmux/.tmux.conf.dev

echo "================="
echo "Configuring Vim"
echo "================="
echo "Creating ~/.vim/bundle"
mkdir -p ~/.vim/bundle
echo "Installing Vundle"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "Installing all other vim plugins listed in .vimrc"
vim -c ":PluginInstall" -c ":q"
echo -e "All Vim plugins installed!\n"

echo "================="
echo "Configuring Ruby Gems"
echo "================="
echo "Installing bundler"
gem install bundler
echo "Installing jekyll"
gem install jekyll
echo -e "All ruby gems installed\n"


# echo "================="
# echo "Downloading fanstasque font"
# echo "================="
# echo "downloading font to ~/fonts"
#wget http://openfontlibrary.org/assets/downloads/fantasque-sans-mono/db52617ba875d08cbd8e080ca3d9f756/fantasque-sans-mono.zip -P ~/fonts/
# echo -e "font downloaded\n"

# echo "NOTE: Remember to open vim and run :PluginInstall in order to \
# install the rest of the plugins. Also don't forget to use the patches once \
# the plugins are installed"
