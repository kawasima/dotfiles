bindkey -e

export HISTSIZE=10000
export SAVE_HIST=100000
export HISTFILE=${HOME}/.zsh_history

# aliases
alias ls="ls --color=auto -F"

# ignore
HISTIGNORE="ls:pwd"

# Path to my zplug installation.
export ZPLUG_HOME=/home/kawasima/.zplug
unset ZPLUG_SHALLOW
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"

zplug "chrissicool/zsh-256color"

zplug "modules/git", from:prezto
zplug "modules/prompt", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto
zstyle ':prezto:module:prompt' theme 'sorin'

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

zplug load

# fzf
function select-history() {
    BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History> ")
    CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# fd - cd to selected directory
function fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
               -o -type d -print 2> /dev/null | fzf +m) && \
        cd "$dir"
}


# fkill - kill process
function fkill() {
    local pid
    pid = $(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -${1:-9}
    fi
}
#source ~/.bin/tmuxinator.zsh
