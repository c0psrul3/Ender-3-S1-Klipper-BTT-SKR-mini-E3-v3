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
    path=-("$HOME/.local/bin")
    path=("$HOME/.local/bin" ${(@)path})
fi
if [ -d "$HOME/bin" ] ; then
    path=("$HOME/bin" ${(@)path})
fi


# # 
# # Zsh styles    (https://thevaluable.dev/zsh-completion-guide-examples/)
zstyle ':completion:*' completer _extensions _complete _approximate
## Completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
## Completion menu
zstyle ':completion:*' menu select
#zstyle ':completion:*' menu select interactive
## Completion menu vi-style movement
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
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
zstyle ':completion:*' file-list all
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' file-sort change reverse
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#zle -C alias-expension complete-word _generic
#bindkey '^a' alias-expension
#zstyle ':completion:alias-expension:*' completer _expand_alias


typeset -xg EDITOR VISUAL
if [[ -e ${commands[nvim]} ]] ; then
    EDITOR="nvim"
elif [[ -e ${commands[vim]} ]] ; then
    EDITOR="vim"
else
    printf "[WARN] vim NOT FOUND\n"
fi
VISUAL="$EDITOR"


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
source <(python3 -m pip completion --zsh)


# Starship
if [[ -e ${commands[starship]} ]] ; then
  eval "$(starship init zsh)"
fi


# apt install \
#   cmake gcc-arm-none-eabi git dfu-util \
#   vim-nox curl wget httpie


# vim: set ts=4 sts=0 sw=4 et nofen :
