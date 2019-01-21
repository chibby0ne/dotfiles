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
# stty -ixon

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;39m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

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

#matlab 
# export PATH=$PATH:/usr/local/MATLAB/R2013b/bin

# texlive
export PATH=$PATH:/usr/local/texlive/2014/bin/x86_64-linux
export MANPATH=$MANPATH:/usr/local/texlive/2014/texmf-dist/doc/man
export INFOPATH=$MANPATH:/usr/local/texlive/2014/texmf-dist/doc/info

#Teensy
# export PATH=$PATH:~/Teensy/arduino-1.0.4

#modelsim
export PATH=$PATH:~/.wine/drive_c/modeltech_6.5/win32

#Algorithms coursera 
export PATH=$PATH:~/algs4/bin

## THIS CODE WAS ADDED BY SOLARIZED_GNOME_TERMINAL script ##
## FOR CORRECT BEHAVIOUR DO NOT MODIFY ##

# getting time and setting dark or light theme
# solarized_files_dir=~/Projects/Solarized_Gnome_Terminal
# sunrise=10#0745
# sunset=10#1643
# time=10#$(date +%H%M)

# if [[ sunrise -le time && time -lt sunset ]]; then
#     eval $(dircolors $solarized_files_dir/dircolors-solarized/dircolors.ansi-light)
# else
#     eval $(dircolors $solarized_files_dir/dircolors-solarized/dircolors.ansi-dark)
# fi

# change manpager from less to vim (http://zameermanji.com/blog/2012/12/30/using-vim-as-manpager/)
# export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

# download_series
export PATH=$PATH:~/Projects/download_series

# cool quotes
declare -a quotes
quotes[0]="\"Genius is 1% inspiration, 99% perspiration\" - Thomas Alva Edison"
quotes[1]="\"Wolves don't lose sleep over the opinion of sheep\""
quotes[2]="\"A goal without a plan is just a wish\" - Antoine de Saint-Exupéry"
quotes[3]="\"Remember that guy that gave up? Neither does anyone else\""
quotes[4]="\"If you've never failed, you've never tried anything new\" - Albert Einstein"
quotes[5]="\"Sucking at something is the first step to becoming sorta of good at something\""
quotes[6]="\"A year from now you'll wish you had started today\" - Karen Lamb"
quotes[7]="\"No man was ever wise by chance\" - Seneca"
quotes[8]="\"It is not how much we have, but how much we enjoy that makes happiness\" - Charles Spurgeon"
echo ${quotes[$RANDOM % ${#quotes[*]}]}

# haskell
export PATH="$HOME/.cabal/bin:/opt/cabal/1.20/bin:/opt/ghc/7.8.4/bin:$PATH"

# necessary to allow vim to use Ctrl-s Ctrl-q mapping
# alias vim="stty -ixon; vim"

# cross compilation
export PATH=$PATH:/opt/cross/bin

# fixing colors for vim inside tmux session
alias tmux="TERM=screen-256color-bce tmux"

# go
export GOPATH=$HOME/Projects/go_workspace

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# added by Miniconda3 installer
export PATH="~/miniconda3/bin:$PATH"
