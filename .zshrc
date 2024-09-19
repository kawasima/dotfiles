umask 022
export HISTSIZE=10000
export SAVE_HIST=100000
export HISTFILE=${HOME}/.zsh_history

# aliases
alias ls="ls --color=auto -F"


# for WSL
if [[ -a /proc/sys/fs/binfmt_misc/WSLInterop ]]
then
    setopt NO_BG_NICE
fi

# ignore
HISTIGNORE="ls:pwd"
export PATH="$HOME/bin:$HOME/.nodebrew/current/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl":/bin

# Path to my zplug installation.
export ZPLUG_HOME=~/.zplug
unset ZPLUG_SHALLOW
if [[ -a "$ZPLUG_HOME/init.zsh" ]]
then
    source $ZPLUG_HOME/init.zsh
else
    source /opt/homebrew/opt/zplug/init.zsh
fi


zplug "modules/autosuggestions", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/git", from:prezto
zplug "modules/prompt", from:prezto
zplug "modules/history", from:prezto
zplug "modules/history-substring-search", from:prezto
zplug "modules/syntax-highlighting", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/tmux", from:prezto

zstyle ':prezto:module:prompt' theme 'sorin'
zstyle ':prezto:module:syntax-highlighting' color 'yes'
#zstyle ':prezto:module:tmux:auto-start' local 'yes'


zplug load

# fzf
function select-history() {
    BUFFER=$(history -n -r 1 | fzf-tmux --no-sort +m --query "$LBUFFER" --prompt="History> ")
    CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# fd - cd to selected directory
function fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
               -o -type d -print 2> /dev/null | fzf-tmux +m) && \
        cd "$dir"
}


# fkill - kill process
function fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf-tmux -m | awk '{print $2}')

    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -${1:-9}
    fi
}

# NVM
if [[ -a "$HOME/.nvm/nvm.sh" ]]
then
    source $HOME/.nvm/nvm.sh
fi

# SDKMAN
export SDKMAN_DIR="/home/kawasima/.sdkman"
[[ -s "/home/kawasima/.sdkman/bin/sdkman-init.sh" ]] && source "/home/kawasima/.sdkman/bin/sdkman-init.sh"
