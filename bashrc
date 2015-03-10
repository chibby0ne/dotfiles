# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# for vim <C-s> shortcut we need to disable <C-s> while vim is running
# vim()
# {
#     local STTYOPTS="$(stty --save)"
#     stty stop '' -ixoff
#     command vim "$@"
#     stty "$STTYOPTS"
# }
stty -ixon

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# set 256 colors term
#export TERM="xterm-256color"

 #make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;31m\]\u@\h\[\033[00m\]:\[\033[01;39m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# smiley () { echo -e ":\\$(($??50:51))"; }
# export PS1="\h\$(smiley) \e[30;1m\w\e[0m\n\$ "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -lh'
alias cl='clear'
alias b='cd ..'
alias bb='cd ../..'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#xilinx ise tools
#source /opt/Xilinx/Vivado/2013.3/settings64.sh
#source /opt/Xilinx/14.7/ISE_DS/settings64.sh
# it says to use ./ instead of source
#clear sourced by Xilinx
#clear
export PATH=$PATH:/opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64
#export PATH=$PATH:/opt/Xilinx/Vivado/2013.3/bin

#cuda
# export PATH=/usr/local/cuda-5.0/bin:$PATH
# export LD_LIBRARY_PATH=/usr/local/cuda-5.0/lib:/usr/local/cuda-5.0/lib64:$LD_LIBRARY_PATH
# export LIBRARY_PATH=$LIBRARY_PATH:/usr/lib/nvidia-current

#guitarpro reader path
export PATH=$PATH:~/Downloads/tuxguitar-1.2-jet

#android-studio
export PATH=$PATH:/opt/android-studio/bin

#acml
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/acml5.3.1/gfortran64/lib:/opt/acml5.3.1/gfortran64_fma4/lib:opt/acml5.3.1/gfortran64_fma4_mp/lib:opt/acml5.3.1/gfortran64_mp/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/acml4.4.0/gfortran64/lib
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/acml4.4.0/gfortran64/include
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/acml4.4.0/gfortran64_mp/lib
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/acml4.4.0/gfortran64_mp/include

# /opt/acml4.4.0/gfortran64/include
# /opt/acml4.4.0/gfortran64/lib
# /opt/acml4.4.0/gfortran64_mp/lib
# /opt/acml4.4.0/gfortran64_mp/include
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/acml4.4.0/gfortran64/lib:/opt/acml4.4.0/gfortran64_mp/lib:/opt/acml4.4.0/gfortran64/include:/opt/acml4.4.0/gfortran64_mp/include

#go lang
# export GOROOT=/usr/local/go
# export PATH=$PATH:/usr/local/go/bin
#export GOROOT=/usr/bin
unset GOROOT
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

#matlab 
# export PATH=$PATH:/usr/local/MATLAB/R2013b/bin

# texlive
export PATH=$PATH:/usr/local/texlive/2014/bin/x86_64-linux
export MANPATH=$MANPATH:/usr/local/texlive/2014/texmf-dist/doc/man
export INFOPATH=$MANPATH:/usr/local/texlive/2014/texmf-dist/doc/info

#Teensy
# export PATH=$PATH:~/Teensy/arduino-1.0.4

# scala
export SCALA_HOME=~/Downloads/scala-2.11.2
export PATH=$PATH:$SCALA_HOME/bin

#modelsim
export PATH=$PATH:~/.wine/drive_c/modeltech_6.5/win32

#jhbuild
export PATH=$PATH:~/.local/bin

#ccache
export CCACHE_COMPRESS=1

#Qt5
export PATH=$PATH:/opt/Qt/5.3/gcc_64/bin

#Algorithms coursera 
export PATH=$PATH:~/algs4/bin


## THIS CODE WAS ADDED BY SOLARIZED_GNOME_TERMINAL script ##
## FOR CORRECT BEHAVIOUR DO NOT MODIFY ##

# getting time and setting dark or light theme
solarized_files_dir=~/Projects/Solarized_Gnome_Terminal
sunrise=10#0656
sunset=10#1824
time=$(date +%k%M)

if [[ sunrise -le time && time -lt sunset ]]; then
    $solarized_files_dir/gnome-terminal-colors-solarized/set_light.sh
    eval $(dircolors $solarized_files_dir/dircolors-solarized/dircolors.ansi-light)
else
    $solarized_files_dir/gnome-terminal-colors-solarized/set_dark.sh
    eval $(dircolors $solarized_files_dir/dircolors-solarized/dircolors.ansi-dark)
fi

# added by Anaconda 2.1.0 installer
export PATH="~/anaconda/bin:$PATH"

# added for use of correct colorscheme solarized in vim inside a session tmux
export TERM=screen-256color-bce