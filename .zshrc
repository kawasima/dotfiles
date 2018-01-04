# autoload
autoload -U  run-help
autoload -Uz add-zsh-hook
autoload -Uz cdr
autoload -Uz colors; colors
autoload -Uz compinit; compinit -u
autoload -Uz is-at-least
autoload -Uz vcs_info
autoload     run-help-git

# Option
setopt auto_menu
setopt auto_cd
setopt auto_pushd
setopt brace_ccl
setopt list_packed
setopt nolistbeep
setopt nonomatch

bindkey -e

# ignore
HISTIGNORE="ls:pwd"

# Path to my zplug installation.
export ZSH=/home/kawasima/.zplug

source $ZSH/zplug

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "peco/peco"

zplug "plugins/git", from:oh-my-zsh, if:"which git"
zplug "lib/git", from:oh-my-zsh, if:"which git"
zplug "themes/pygmarion", from:oh-my-zsh

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

zplug load

source ~/.bin/tmuxinator.zsh

