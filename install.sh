#!/bin/bash

# $1: status of last command
# $2: succesful message
# $3: failure message
# $4: whether to exit script or not. default don't exit
function printMessage() {
    if [[ $1 -eq 0 ]]; then
        echo -e $2
    else
        echo -e $3
        if [[ -n "$4" && "$4" == "EXIT" ]]; then
            exit 1
        fi
    fi
}

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "================="
echo "Installing several very useful packages (needs sudo)"
echo "================="
distro=$(cat /etc/*-release | grep ^NAME= | sed -E 's/NAME="(\w+)\s+\w+"/\1/g' | tr "[:upper:]" "[:lower:]")
if [[ "$distro" == "arch" ]]; then
    sudo pacman -Syyu --noconfirm && sudo pacman -S vim tmux dmidecode ruby rubygems \
        rust go python docker curl powerline-fonts ttf-dejavu noto-fonts --noconfirm
elif [[ "$distro" == "ubuntu" || "$distro" == "debian" || "$distro" == "raspbian" ]]; then
    installDistro=$distro
    sudo apt update && sudo apt install vim tmux dmidecode ruby-dev libgemplugin-ruby rustc python -Vy
    # Taken from dockers docs: https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -Vy
    if [[ "$installDistro" == "raspbian" ]]; then
        installDistro=debian
    fi
    curl -fsSL https://download.docker.com/linux/$installDistro/gpg | sudo apt-key add -
    if [[ "$distro" == "raspbian" ]]; then
        # Taken from https://docs.docker.com/install/linux/docker-ce/debian/#set-up-the-repository
        echo "deb [arch=armhf] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | \
            sudo tee /etc/apt/sources.list.d/docker.list
    else
        # Taken from https://docs.docker.com/install/linux/docker-ce/debian/#set-up-the-repository
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$distro \
            $(lsb_release -cs) stable"
    fi
    sudo apt update
    sudo apt install docker-ce -Vy
fi
printMessage $? "All programs installed\n" "Error installing all the programs\n" "EXIT"

echo "================="
echo "Setting symlinks"
echo "================="
for file in bashrc zshrc Xdefaults vimrc gitconfig tern-config profile; do
    echo "Setting $file"
    ln -sf ${SCRIPT_DIR}/$file ~/.$file
    printMessage $? "$file symlink set" "Failed to set $file symlink"
done

# echo "Setting bashrc"
# ln -sf ${SCRIPT_DIR}/bashrc ~/.bashrc
# echo "Setting zshrc"
# ln -sf ${SCRIPT_DIR}/zshrc ~/.zshrc
# echo "Setting Xdefaults"
# ln -sf ${SCRIPT_DIR}/Xdefaults ~/.Xdefaults
echo "Setting .config/i3/config"
mkdir -p ~/.config/i3 && ln -sf ${SCRIPT_DIR}/i3/config ~/.config/i3/config
printMessage $? ".config/i3/config symlink set" "Failed to set .config/i3/config symlink"
echo "Setting i3 lockscreen picture"
mkdir -p ~/Pictures && ln -sf ${SCRIPT_DIR}/i3/marscolonization.png ~/Pictures/marscolonization.png
printMessage $? "i3 lock screen picture symlink set" "Failed to set i3 lockscreen picture symlink"
echo "Setting .tmux/tmux.conf.dev"
mkdir ~/.tmux && ln -sf ${SCRIPT_DIR}/tmux/tmux.conf.dev ~/.tmux/.tmux.conf.dev
printMessage $? "i3 lock screen picture symlink set\n" "Failed to set i3 lockscreen picture symlink\n"
# echo "Setting vimrc"
# ln -sf ${SCRIPT_DIR}/vimrc ~/.vimrc
# echo -e "Setting tmux.conf"
# ln -sf ${SCRIPT_DIR}/tmux.conf ~/.tmux.conf
# echo -e "Setting gitconfig"
# ln -sf ${SCRIPT_DIR}/gitconfig ~/.gitconfig
# echo -e "Setting global tern-config (required for js completion in vim with YCM)"
# ln -sf ${SCRIPT_DIR}/tern-config ~/.tern-config
# echo -e "Setting profile\n"
# ln -sf ${SCRIPT_DIR}/profile ~/.profile


# Find computer model to see if the scripts for handling fn keys are required
laptop_model=$(sudo dmidecode | grep 'Version: ' | head -n 1 | sed 's/Version: \(.*\)/\1/g' | sed 's/[[:blank:]]//g')

# Copy the scripts for making Fn keys work in Arch Linux for Asus Zenbook UX330 Notebook
if [[ "$distro" == "arch" && "$laptop_model" == "UX330UAK.301" ]]; then
    echo "================="
    echo "Setting symlinks and binaries for handling function keys in Asus Zenbook Laptop (needs sudo)"
    echo "================="
    echo "Setting symlink kb-light.py (Keyboard Backlight control)"
    ln -sf ${SCRIPT_DIR}/i3/kb-light.py ~/.config/i3/kb-light.py
    printMessage $? "kb-light.py symlink set" "Failed to set kb-light.py symlink"
    echo "Setting symlink toogletouchpad.sh (Toogle touchpad control)"
    ln -sf ${SCRIPT_DIR}/i3/toogletouchpad.sh ~/.config/i3/toogletouchpad.sh
    printMessage $? "toogletouchpad.sh symlink set" "Failed to set toogletouchpad.sh symlink"
    echo "Setting adjust_brightness (Screen Brightness control)"
    sudo cp ${SCRIPT_DIR}/i3/adjust_brightness /usr/local/bin/
    printMessage $? "adjust_brightness installed\n" "Failed to install adjust_brightness\n"
fi

# echo "================="
# echo "Setting up .tmux.conf.dev"
# echo "================="
# echo "Creating ~/.tmux"
# mkdir ~/.tmux
# echo -e "Setting symlink\n"
# ln -sf ${SCRIPT_DIR}/tmux/tmux.conf.dev ~/.tmux/.tmux.conf.dev

echo "================="
echo "Configuring Vim"
echo "================="
echo "Creating ~/.vim/bundle"
mkdir -p ~/.vim/bundle
printMessage $? "~/.vim/bundle created" "Failed to create ~/.vim/bundle"
echo "Cloning Vundle"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
printMessage $? "Vundle cloned" "Failed to clone Vundle"
echo "Installing all other vim plugins listed in .vimrc"
vim -c ":PluginInstall" -c ":q"
printMessage $? "vim plugins installed" "Failed to install vim plugins"
echo "Installing YouCompleteMe"
cd ~/.vim/bundle/YouCompleteMe/ && ./install.py --all
printMessage $? "YouCompleteMe installed\n" "Failed to install YouCompleteMe\n"

echo "================="
echo "Configuring Ruby Gems"
echo "================="
for app in bundler jekyll; do
    echo "Installing $app"
    gem install $app
    printMessage "$app installed" "Error installing $app"
done
# echo "Installing bundler"
# gem install bundler
# echo "Installing jekyll"
# gem install jekyll
