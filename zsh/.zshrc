# Fix emacs-tramp. My prompt freeze emacs when trying ssh connection
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="norm"
ZSH_THEME="gitster"
#ZSH_THEME="lambda-mod"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

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
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git django docker pip python sudo tmux virtualenvwrapper)


# User configuration

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# ssh
 export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# My own zsh conf
# Rehash needed for completion when a new package is installed
zstyle ':completion:*' rehash true

# Completion on parent dirs
zstyle ':completion:*' special-dirs true

#-----------------------------
# Source Things
#-----------------------------
source /usr/share/doc/pkgfile/command-not-found.zsh
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#-----------------------------
# Variables
#-----------------------------
export BROWSER="firefox"
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export CC="clang"
export CXX="clang++"

# source .env files in .zsh.d
for i in ${HOME}/.zsh.d/*.env; do source $i; done

# Variables para xfluxd
export LAT=40.3
export LON=-3.7

# Android
export ANDROID_SDK=~/Android/Sdk
export ANDROID_TOOLS=$ANDROID_SDK/tools/bin
export ANDROID_PLATFORM_TOOLS=$ANDROID_SDK/platform-tools

# Python
export PYTHONPATH=${PYTHONPATH}:~/.my-python-modules/

# Apache Airflow
export AIRFLOW_HOME=/opt/airflow

#GNU Global
export GTAGSLIBPATH=$HOME/.gtags/

# Path
export PATH=$PATH:$ANDROID_TOOLS:$ANDROID_PLATFORM_TOOLS:~/.local/bin


# Custom emacsanywhere command. Set custom window title
# Can be invoked with ${EA_EDITOR[@]}
#export EA_EDITOR=(emacsclient -a "" -c --frame-parameters='(quote (name . "scratchemacs-frame"))')

#-----------------------------
# Alias stuff 
#-----------------------------
alias pstartx='sudo -n /usr/bin/prime-switch && startx'
alias nvtemp='nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader'

# clear for emacs-libvterm
if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    alias clear='printf "\e]51;Evterm-clear-scrollback\e\\";tput clear'
fi

#-----------------------------
# Functions stuff 
#-----------------------------
mkcd () {
    mkdir -p ${1} && cd ${1}
}

t () {
    cd $(mktemp -d /tmp/$1.XXXX)
}

#------------------------------
# ShellFuncs
#------------------------------
# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/labellson/GCloud/google-cloud-sdk/path.zsh.inc' ]; then source '/home/labellson/GCloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/labellson/GCloud/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/labellson/GCloud/google-cloud-sdk/completion.zsh.inc'; fi

# Enable ZSH Tab completion for cht.sh
fpath=(~/.zsh.d/ $fpath)

# Completion for apache airflow. Requires python-argcomplete
autoload bashcompinit
bashcompinit
eval "$(register-python-argcomplete airflow)"
