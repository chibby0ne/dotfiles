# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ssh-agent exercism zsh-completions zsh-autosuggestions)

# User configuration

# export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
# export MANPATH="/usr/local/man:$MANPATH"

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
# DISABLE_MAGIC_FUNCTIONS=true
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

######################################
#
# Functions
#
######################################

eval `dircolors ~/Projects/dircolors-solarized/dircolors.ansi-dark`
solarized_dark() {
    eval `dircolors ~/Projects/dircolors-solarized/dircolors.ansi-dark`
    sed -i 's/*background: #fdf6e3/*background: #002b36/g' ~/.Xresources
    sed -i 's/set background=light/set background=dark/g' ~/.config/nvim/init.vim
    xrdb ~/.Xresources
    sed -i 's/^colors: \*light/colors: *dark/g' ~/.config/alacritty/alacritty.yml

    # Uncomment dark and comment light if necessary
    sed -i 's/^#\(.*solarized-dark.*\)/\1/g' ~/.taskrc
    sed -i 's/^\([^#]\)\(.*solarized-light.*\)/#\1\2/g' ~/.taskrc

    export BAT_THEME='Solarized (dark)'
}

solarized_light() {
    eval `dircolors ~/Projects/dircolors-solarized/dircolors.ansi-light`
    sed -i 's/*background: #002b36/*background: #fdf6e3/g' ~/.Xresources
    sed -i 's/set background=dark/set background=light/g' ~/.config/nvim/init.vim
    xrdb ~/.Xresources
    sed -i 's/^colors: \*dark/colors: *light/g' ~/.config/alacritty/alacritty.yml

    # Uncomment light and comment dark if necessary
    sed -i 's/^#\(.*solarized-light.*\)/\1/g' ~/.taskrc
    sed -i 's/^\([^#]\)\(.*solarized-dark.*\)/#\1\2/g' ~/.taskrc

    export BAT_THEME='Solarized (light)'
}

default_terminal() {
    cp ~/.config/xfce4/terminal/terminalrc.bak ~/.config/xfce4/terminal/terminalrc
}

add_to_pythonpath() {
    [[ ":$PYTHONPATH:" != *":${PWD}:"* ]] && PYTHONPATH="${PWD}:${PYTHONPATH}"
    export PYTHONPATH
}


######################################
#
# Aliases
#
######################################

alias l="ls -lh"
alias ll="ls -lha"
alias cl="clear"
alias hackerrank="cd ~/Projects/HackerRank/Algorithms/"
alias vi='nvim'
alias vim='nvim'
alias netstat='ss'
alias def="sdcv"
alias sudo="sudo -E"


######################################
#
# Exports and Sourcing
#
######################################

# Get color suport for 'less'
export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc...
[[ -f ~/.LESS_TERMCAP ]] && source ~/.LESS_TERMCAP

# For Jupyter Notebooks 'Failed to launch GPU process' (https://github.com/jupyter/notebook/issues/2836)
export BROWSER=firefox-developer-edition

# Set XDG_DATA_HOME
if [[ -z "$XDG_DATA_HOME" ]]; then
    export XDG_DATA_HOME=$HOME/.config
fi

# For sdcv (offline dictionary)
# Where to store the dictionaries for sdcv
export STARDICT_DATA_DIR=$XDG_DATA_HOME

export GPG_TTY=$(tty)

# Added after installing nvm (node version manager)
if [ -f /usr/share/nvm/init-nvm.sh ]; then
    source /usr/share/nvm/init-nvm.sh
fi

# Miniconda
if [[ -f  /opt/miniconda3/etc/profile.d/conda.sh ]]; then
    source /opt/miniconda3/etc/profile.d/conda.sh
    export PATH="$PATH:/opt/miniconda3/bin"
fi

# Set width of man pages to 80
export MANWIDTH=80

# Editor
export VISUAL="nvim"

# Go related
export GOPATH=~/Projects/go_workspace
export GOBIN=$GOPATH/bin

# Binaries from GOPATH
export PATH=$GOBIN:$PATH

# Other binaries
export PATH=$PATH:~/.local/bin

# Binaries installed with cargo, assuming cargo is installed using rustup
export PATH=$PATH:~/.cargo/bin

# Home installed binaries
export PATH=$PATH:~/.bin

# For cuda installed in /opt/cuda (pacman does this too)
if [[ -x /opt/cuda/bin/nvcc ]]; then
    export PATH=$PATH:/opt/cuda/bin
    export LD_LIBRARY_PATH=/opt/cuda/lib64
fi

# On-demand rehash
# Needs also the pacman hook. See here:
# https://wiki.archlinux.org/index.php/Zsh#On-demand_rehash

zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() (
    if [[ -a /var/cache/zsh/pacman ]]; then
        local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
        if (( $zshcache_time < $paccache_time )); then
            rehash
            zshcache_time="$paccache_time"
        fi
    fi
)

add-zsh-hook -Uz precmd rehash_precmd

if [[ -f ~/.ghcup/env ]]; then
    source ~/.ghcup/env
fi

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

to_hex() {
    echo "obase=16; $1" | bc
}

to_dec() {
    echo "ibase=16; $1" | bc
}

# Enable go modules
export GO111MODULE=on

# for PIA
export PATH=/opt/piavpn/bin:$PATH

# bundle
export PATH=/home/tesla/.gem/ruby/2.7.0/bin:$PATH

# Needs to be Java 11 for correct behavior of vim's coc-metals
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk/

export SYSTEMD_EDITOR=/bin/nvim

zeal-docs-fix() {
    pushd "$HOME/.local/share/Zeal/Zeal/docsets" >/dev/null || return
    find . -iname 'react-main*.js' -exec rm '{}' \;
    popd >/dev/null || exit
}


for env in $(ls -1 ~/.oh-my-zsh/custom/completions/); do
    source ~/.oh-my-zsh/custom/completions/$env
done

# source /usr/share/zsh/site-functions/_gcloud

# Change highlight color for zsh-autosuggestions with solarized_dark theme
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'



export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '~/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '~/Downloads/google-cloud-sdk/completion.zsh.inc'; fi


# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
