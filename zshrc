# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
# ZSH_CUSTOM=${ZSH}/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ssh-agent zsh-autosuggestions zsh-completions colored-man-pages direnv)

# User configuration
# Needed for zsh-completions
# fpath+=${ZSH_CUSTOM}/plugins/zsh-completions/src
# fpath+=${ZSH_CUSTOM}/completions

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

to_hex() {
    echo "obase=16; $1" | bc
}

to_dec() {
    echo "ibase=16; $1" | bc
}

######################################
#
# Aliases
#
######################################

alias l="ls -lh"
alias ll="ls -lha"
alias cl="clear"
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/chibby0ne/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/chibby0ne/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/chibby0ne/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/chibby0ne/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Get color suport for 'less'
export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc...
[[ -f /home/chibby0ne/.LESS_TERMCAP ]] && source /home/chibby0ne/.LESS_TERMCAP

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
export GOPATH=/home/chibby0ne/Projects/go_workspace
export GOBIN=$GOPATH/bin

# Binaries from GOPATH
export PATH=$GOBIN:$PATH

# Other binaries
export PATH=$PATH:/home/chibby0ne/.local/bin

# Binaries installed with cargo, assuming cargo is installed using rustup
export PATH=$PATH:/home/chibby0ne/.cargo/bin

# Home installed binaries
export PATH=$PATH:/home/chibby0ne/.bin

# fzf
if [[ $(uname -v | awk '{ print $1 }') =~ NixOS ]]; then
    source /run/current-system/sw/share/fzf/key-bindings.zsh
    source /run/current-system/sw/share/fzf/completion.zsh
elif [[ $(uname) == "Linux" ]]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi

# nvim editor of systemd units
export SYSTEMD_EDITOR=/run/current-system/sw/bin/nvim

# Jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Change highlight color for zsh-autosuggestions with solarized_dark theme
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

#############################
##
## Quotes
##
#############################
bold=$(tput bold)
normal=$(tput sgr0)
quotes=(
    "${bold}\"Only time can heal what reason cannot\"${normal} -  Seneca"
    "${bold}\"Any person capable of angering you becomes your master\"${normal} -  Epictetus"
    "${bold}\"Have patience. All things are difficult before they become easy\"${normal} -  Saadi Shirazi"
    "${bold}\"It is no the man who has little but he who craves more that is poor\"${normal} -  Seneca"
    "${bold}\"Knowing is not enough, we must apply. Willing is not enough, we must do\"${normal} -  Johann von Goethe"
    "${bold}\"More is lost by indecision that wrong decision\"${normal} -  Marcus Tullius Cicero"
    "${bold}\"Luck is what happens when preparation meets opportunity\"${normal} - Seneca"
    "${bold}\"How much time one saves who does not look to see what their neighbor says or does or thinks.\"${normal} - Marcus Aurelius"
    "${bold}\"One day or day one. You decide\"${normal} - Unknown"
    "${bold}\"Worrying is like paying a debt you don't owe\"${normal} - Mark Twain"
    "${bold}\"It is difficult to find happiness within oneself but it is impossible to find it anywhere else.\"${normal} - Arthur Schopenhauer"
    "${bold}\"What we fear doing most is usually what we most need to do\"${normal} - Tim Ferris"
    "${bold}\"Don't judge each day by the hearvest you reap but by the seeds that you plant\"${normal} - Robert Louis Stevenson"
    "${bold}\"Don't wait. The time will never be just right\"${normal} - Napoleon Hill"
    "${bold}\"No man ever steps in the same river twice, for it is not the same river and he is not the same man.\"${normal} - Heraclitus"
    "${bold}\"The smallest deed is better than the grandest intention\"${normal} - John Burroughs"
    "${bold}\"Difficulties strengthen the mind, as labor does the body\"${normal} - Seneca"
    "${bold}\"Failure is success in progress\"${normal} - Albert Einstein"
    "${bold}\"Knowledge isn't power until it is applied\"${normal} - Dale Carnegie"
    "${bold}\"There is only one way to avoid criticism: Do nothing, say nothing and be nothing\"${normal} - Elbert Hubbard"
    "${bold}\"It is the the mark of an educated mind to be able to entertain a thought without accepting it\"${normal} - Aristotle"
    "${bold}\"Putting off things is the biggest waste of life: It snatches away each day as it comes and denies us the present by promising the future\"${normal} - Seneca"
    "${bold}\"Learning is the only thing the mind never exhausts, never fears, and never regrets\"${normal} - Leonardo da Vinci"
    "${bold}\"Everything can be taken from a man but on thing: the last of the human freedoms - to choose one's attitude in any given set of circumstances\"${normal} - Viktor Frankl"
    "${bold}\"Only staying active will make you want to live a hundred years\"${normal} - Japanese proverb"
    "${bold}\"Hard times create strong men. Strong men create good times. Good times create weak men. Weak men create hard times\"${normal} - G. Michael Hopf"
    "${bold}\"Everyone buys books, few ever read them. Everyone wants growth, few accept pain. Everyone wants to be happier, few ever change. Intention is nothing without action, but action is nothing without intention.\"${normal} - Steven Bartlett"
    "${bold}\"No good thing is pleasant to possess, without friends to share it\"${normal} - Seneca"
    "${bold}\"The man who does not read has no advantage over the man who cannot read\"${normal} - Mark Twain"
    "${bold}\"The nearer a man comes to calm mind, the closer he is to strength\"${normal} - Marcus Aurelius"
    "${bold}\"I don't want to be part of a world, where being kind is a weakness\"${normal} - Keanu Reeves"
    "${bold}\"Stay close to anything that makes you glad you are alive\"${normal} - Hafez"
    "${bold}\"Writing is nature's way of letting you know how sloppy your thinking is\"${normal} - Dick Guindon"
    "${bold}\"Reading 1 hour a day is only 4% of your day, but that 4% will put you at the top of your field in 10 years. Find the time\"${normal} - Patrick Bet-David"
    "${bold}\"Change is hard at first, messy in the middle and gorgeous at the end\"${normal} - Robin Sharma"
    "${bold}\"A fit body, a calm mind, a house full of love. These things cannot be bought - they must be earned\"${normal} - Naval Ravikant"
    "${bold}\"Your life does not get better by chance, it gets better by change\"${normal} - Jim Rohn"
    "${bold}\"The best revenge is to not be like your enemy\"${normal} - Marcus Aurelius"
)
# Allow having the array[${i}] syntax
setopt KSH_ARRAYS
index=$(( $RANDOM % ${#quotes[@]} ))
echo ${quotes[${index}]}
# Remove it for the rest of the scripts
unsetopt KSH_ARRAYS

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/usr/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/tesla/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<


# Required by tuir
export MAILCAPS=~/.config/tuir/mailcap
