#!/bin/bash

########################
# Sets a variable called INSTALL_$2, depending of prompt where $2 is the second
# argument passed, which can be later used for checking status.
#
# $1: verb action and name of the applications -  string - e.g: install basic packages
# $2: name of the variable to set - string - e.g: PACKAGES
#
########################
function choose_yes_or_no() {
    while [[ true ]]; do
        read -p "Do you wish to ${1}? " yn
        case ${yn} in
            [Yy]* ) export ${2}=1; break;;
            [Nn]* ) export ${2}=0; break;;
            * ) echo "Please enter yes or no";;
        esac
    done
}

########################
# Exits the function in which it is called if the variable to check is not equal 1
#
# $1: verb actiona and name in present continous tense e.g: installing basic packages
# $2: name of the variable to check e.g: PACKAGES
########################
function check_value_equals_one_otherwise_return() {
    if [[ ${2} -ne 1  ]]; then
        echo "Skipping ${1}"
        return
    fi
}


########################
# Used for printing
# $1: status of last command
# $2: succesful message
# $3: failure message
# $4: whether to exit script or not. default don't exit
########################
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

########################
# Creates a 1 GB Swap Space
# Required for compiling YouCompleteMe
########################
function createSwapSpace() {
    # Allocate 1 GB
    echo "Allocating 1 GB"
    sudo dd if=/dev/zero of=/swapfile1 bs=4M count=256

    # Secure swap area
    echo "Securing swap file"
    sudo chown root:root /swapfile1
    sudo chmod 0600 /swapfile

    # Set up swap area
    echo "Setting up swap file"
    sudo mkswap /swapfile1

    # Activate swap space
    echo "Activating swap file"
    sudo swapon /swapfile1

    # Update fstab file so that it is mounted at boot
    echo -e "Updating fstab to automount swapfile at reboot\n"
    sudo sh -c "echo '/swapfile1 none swap sw 0 0' >> /etc/fstab"
}

######################
# Checks if there's at least 1GB of swap space available, if not it creates a
# swap space of 1GB
######################
function handleSwapSpace() {
    check_value_equals_one_otherwise_return "installing YouCompleteMe" "YCM"
    swap_space=$(free -g | grep Swap | sed -E 's/Swap:\s+(\w+)\s+.*/\1/g')
    if [[ $swap_space -lt 1 ]]; then
        echo "Need to create swap space before compiling YouCompleteMe"
        echo "================="
        echo "Creating swap space (needs sudo)"
        echo "================="
        createSwapSpace
    fi
}


function installBasicPackages() {
    check_value_equals_one_otherwise_return "installing basic packages" "PACKAGES"
    echo "================="
    echo "Installing several very useful packages (needs sudo)"
    echo "================="
    distro=$(cat /etc/*-release | grep ^NAME= | sed -E 's/NAME="(\w+)\s+.*"/\1/g' | tr "[:upper:]" "[:lower:]")
    if [[ "$distro" == "arch" ]]; then
        sudo pacman -Syyu --noconfirm && sudo pacman -S gvim nvim tmux dmidecode ruby rubygems \
            rustup go python python-dev docker curl noto-fonts cmake alacritty \
            npm node --noconfirm
    elif [[ "$distro" == "ubuntu" || "$distro" == "debian" || "$distro" == "raspbian" ]]; then
        sudo apt update && sudo apt upgrade -Vy && sudo apt install gvim nvim vim-nox tmux \
            dmidecode ruby-dev rustup python python-dev cmake npm node -Vy
        curl -sSL get.docker.com | sh
    fi
    printMessage $? "All programs installed\n" "Error installing all the programs\n" "EXIT"
}


function installingSymlinks() {
    check_value_equals_one_otherwise_return "installing symlinks" "SYMLINKS"

    # Get script directory
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

    echo "================="
    echo "Setting symlinks"
    echo "================="
    for file in bashrc zshrc Xresources vimrc gitconfig tern-config profile nvim; do
        echo "Setting $file"
        ln -sf ${SCRIPT_DIR}/$file ~/.$file
        printMessage $? "$file symlink set" "Failed to set $file symlink"
    done

    echo "Setting alacritty.yml"
    mkdir -p ~/.config/alacritty/ && ln -sf ${SCRIPT_DIR}/alacritty.yml ~/.config/alacritty/alacritty.yml
    printMessage $? "alacritty.yml symlink set\n" "Failed to set alacritty.yml symlink\n"
    echo "Setting .config/i3/config"
    mkdir -p ~/.config/i3 && ln -sf ${SCRIPT_DIR}/i3/config ~/.config/i3/config
    printMessage $? ".config/i3/config symlink set" "Failed to set .config/i3/config symlink"
    echo "Setting i3 lockscreen picture"
    mkdir -p ~/Pictures && ln -sf ${SCRIPT_DIR}/i3/marscolonization.png ~/Pictures/marscolonization.png
    printMessage $? "i3 lock screen picture symlink set" "Failed to set i3 lockscreen picture symlink"
    echo "Setting .tmux/tmux.conf.dev"
    mkdir -p ~/.tmux && ln -sf ${SCRIPT_DIR}/tmux/tmux.conf.dev ~/.tmux/.tmux.conf.dev
    printMessage $? "i3 lock screen picture symlink set\n" "Failed to set i3 lockscreen picture symlink\n"

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

}


function configureVim() {
    check_value_equals_one_otherwise_return "configuring vim" "VIM"
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
    vim -c ":PluginInstall" -c ":q" -c ":q"
    printMessage $? "vim plugins installed" "Failed to install vim plugins"
    check_value_equals_one_otherwise_return "YCM" "installing YouCompleteMe"
    echo "Installing YouCompleteMe (with support for all languages)"
    cd ~/.vim/bundle/YouCompleteMe/ && ./install.py --clang-completer --go-completer --rust-completer --js-completer --java-completer
    printMessage $? "YouCompleteMe installed\n" "Failed to install YouCompleteMe\n"
}


function configureNeovim() {
    check_value_equals_one_otherwise_return "configuring neovim" "NVIM"
    echo "================="
    echo "Configuring Neovim"
    echo "================="
    echo "Creating ~/.config/nvim/"
    mkdir -p ~/.config/nvim
    printMessage $? "~/.config/nvim created" "Failed to create ~/.config/nvim"
    echo "Copying init.vim"
    cp nvim/init.vim ~/.config/nvim
    printMessage $? "~/.config/nvim/init.vim copied" "Failed to copy ~/.config/nvim/init.vim"
    # Taken from https://github.com/junegunn/vim-plug
    echo "Installing vim-plug"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    printMessage $? "vim-plug installed" "Failed to installed vim-plug"
    echo "Installing python-neovim (required for deoplete nvim plugin)"
    sudo pacman -S python-neovim
    printMessage $? "python-neovim installed\n" "Failed to install python-neovim\n"
    echo "Installing gocode (required for deoplete-go nvim plugin)"
    go get -u github.com/nsf/gocode
    printMessage $? "gocode installed\n" "Failed to install gocode\n"
    echo "Installing clang (required for deoplete-clang nvim plugin)"
    sudo pacman -S clang
    printMessage $? "clang installed\n" "Failed to install clang\n"
    echo "Installing racer (required for deoplete-rust nvim plugin)"
    cargo install racer
    printMessage $? "racer installed\n" "Failed to install racer\n"
    echo "Creating virtualenv for neovim (so that we can use nvim inside virtualenv)"
    virtualenv ~/.config/nvim/env
    printMessage $? "virtualenv ~/.config/nvim/env created\n" "Failed to create ~/.config/nvim/env\n"
    echo "Activating virtualenv environment"
    source ~/.config/nvim/env/bin/activate
    printMessage $? "~/.config/nvim/env/bin/activate sourced\n" "Failed to source ~/.config/nvim/env/bin/activate\n"
    echo "Installing neovim python module"
    pip install -r nvim/requirements.txt
    printMessage $? "neovim python module (in virtualenv) installed\n" "Failed to install neovim python module (in virtualenv)\n"
    echo "Deactiving virtualenv environment"
    deactivate
    printMessage $? "virtualenv environment deactivated\n" "Failed to source deactivate virtualenv environment\n"
    echo "Installing all other nvim plugins listed in init.vim"
    nvim -c ":PlugInstall" -c ":q" -c ":q"
    printMessage $? "nvim plugins installed" "Failed to install nvim plugins"
    echo "Installing coc-extensions"
    nvim/install_coc_plugins.sh
}


function configureRubyGems() {
    check_value_equals_one_otherwise_return "configuring Ruby Gems" "RUBYGEMS"
    echo "================="
    echo "Configuring Ruby Gems"
    echo "================="
    for app in bundler jekyll; do
        echo "Installing $app"
        sudo gem install $app
        printMessage $? "$app installed" "Error installing $app"
    done
}


# Main function
function main() {
    choose_yes_or_no "install YouCompleteMe" "YCM"
    choose_yes_or_no "install basic packages" "PACKAGES"
    choose_yes_or_no "install symlinks" "SYMLINKS"
    choose_yes_or_no "configure vim" "VIM"
    choose_yes_or_no "configure neovim" "NVIM"
    choose_yes_or_no "configure ruby gems" "RUBYGEMS"
    handleSwapSpace
    installBasicPackages
    installSymLinks
    configureVim
    configureNeovim
    configureRubyGems
}

main
