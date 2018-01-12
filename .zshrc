bindkey -e

export HISTSIZE=10000
export SAVE_HIST=100000
export HISTFILE=${HOME}/.zsh_history

# ignore
HISTIGNORE="ls:pwd"

# Path to my zplug installation.
export ZPLUG_HOME=/home/kawasima/.zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "peco/peco"

zplug "chrissicool/zsh-256color"

zplug "modules/git", from:prezto
zplug "modules/prompt", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto
zstyle ':prezto:module:prompt' theme 'sorin'

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

zplug load

#source ~/.bin/tmuxinator.zsh

