# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    path=("$HOME/.local/bin" ${(@)path})
fi
if [ -d "$HOME/bin" ] ; then
    path=("$HOME/bin" ${(@)path})
fi
if [ -d "/usr/sbin" ] ; then
    path=(${(@)path} "/usr/sbin")
fi
if [ -d "/usr/local/sbin" ] ; then
    path=(${(@)path} "/usr/local/sbin")
fi


#
# ZSH completion
#   [examples](https://thevaluable.dev/zsh-completion-guide-examples/)
autoload -Uz compinit
compinit
zmodload zsh/complist
typeset -xg COMPLETION_WAITING_DOTS="true"

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' completer _extensions _complete _approximate
## Completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
## Completion menu
zstyle ':completion:*' menu select interactive
#zstyle ':completion:*' menu select
#zstyle ':completion:*' menu yes=long select
zstyle ':completion:::::default' menu yes select

# To get new binaries into PATH
zstyle ':completion:*' rehash true

# Zsh reverse auto-completion
bindkey '^[[Z' reverse-menu-complete

## Formatting completions
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:descriptions' format '%U%K{yellow} %F{green}-- %F{red} %BNICE!1! %b%f %d --%f%k%u'
## Completion grouping
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands
## Complete files list with colors, sorting, fuzzy matching
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-list false      ## disable long list for files in complete menu
zstyle ':completion:*' file-sort modification date
zstyle ':completion:*' file-sort change reverse
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## Completion menu vi-style movement
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Bypass Completion (Ctrl+SPACE)
bindkey "^ " magic-space           # control-space to bypass completion

## Zsh history 
alias history="fc -lin 100"
# the detailed meaning of the below three variable can be found in `man zshparam`.
export HISTFILE=~/.histfile
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

# The meaning of these options can be found in man page of `zshoptions`.
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
#bindkey "^R" fzf-history-widget

## [Zsh history substring search](https://github.com/zsh-users/zsh-history-substring-search)
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down

## Zsh syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Alias Expansion   (Ctrl+a)
zle -C alias-expension complete-word _generic
bindkey '^a' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Zle function `edit-command-line`
if [[ $(find $fpath -type f -name "edit-command-line" 2>/dev/null | wc -l) > 0 ]] ; then
    autoload -Uz edit-command-line
    zle -N edit-command-line
    bindkey '^E' edit-command-line
fi


function fpaths() {
    printf "%s\n" ${fpath}
}

function paths() {
    printf "%s\n" ${path}
}

#  # Expanding Global Alias (https://blog.lftechnology.com/command-line-productivity-with-zsh-aliases-28b7cebfdff9#61ee)
#  globalias() {
#     if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
#       zle _expand_alias
#       zle expand-word
#     fi
#     zle self-insert
#  }
#  
#  zle -N globalias
#  
#  bindkey " " globalias
#  bindkey "^ " magic-space           # control-space to bypass completion
#  bindkey -M isearch " " magic-space # normal space during searches
#  
#  
#  ##
#  ## some global aliases
#  ##
#  alias -g G='|grep'
#  alias -g L='|bat'
#  alias -g S='-Ss'



typeset -xg EDITOR VISUAL SYSTEMD_EDITOR
if [[ -e ${commands[nvim]} ]] ; then
    EDITOR="nvim"
elif [[ -e ${commands[vim]} ]] ; then
    EDITOR="vim"
else
    printf "[WARN] vim NOT FOUND\n"
fi
VISUAL="$EDITOR"
##
## NOTE: When defining SYSTEMD_EDITOR, should include the following in sudoers:
##     ```
##     Defaults  env_keep += "SYSTEMD_EDITOR" ```
##     ```
##
typeset -xg SYSTEMD_EDITOR="$EDITOR"


# define word separators (exclude '/')
WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

# fix keyboard
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word


# directory listing aliases
alias ls="/bin/ls -F --color=auto"
alias lA="ls -A"
alias l1="ls -Ah1"
alias ll="ls -Ahl"
alias ld="ls -Ahd"
alias lltr="ll -tr"

alias grep="grep --color=auto --no-messages --exclude-dir='.git' --exclude='.zhistory' --line-number --with-filename"

alias bat="batcat"


# Other Aliases
if [[ -e /usr/bin/watch ]] ; then
    alias watch="/usr/bin/watch --color --differences --errexit --no-title"
fi


# Klipper / scripts
if [ -e $HOME/klipper/scripts ] ; then
    path+=("$HOME/klipper/scripts")
fi


#http --download https://github.com/ku1ik/vim-monokai/blob/master/colors/monokai.vim --output $HOME/.vim/colors/monokai.vim

# Completions
. <(python3 -m pip completion --zsh)


# Starship
if [[ -e ${commands[starship]} ]] ; then
  eval "$(starship init zsh)"
fi


# apt install \
#   cmake gcc-arm-none-eabi git dfu-util \
#   vim-nox curl wget httpie


# vim: set ts=4 sts=0 sw=4 et nofen :
