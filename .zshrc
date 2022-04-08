alias kssh="kitty +kitten ssh"
alias sudo="sudo --preserve-env=TERMINFO"
alias ls="ls --color=auto"
alias less="less -i"

export EDITOR=/usr/bin/vim

bindkey -v
bindkey -a "h" vi-backward-char
bindkey -a "t" down-line-or-history
bindkey -a "n" up-line-or-history
bindkey -a "s" vi-forward-char
bindkey -a "l" vi-repeat-search
bindkey -a "L" vi-rev-repeat-search

# allow :w
zle -A accept-line w
zle -A accept-line x

setopt HIST_IGNORE_ALL_DUPS

# completion
unsetopt MENU_COMPLETE
unsetopt FLOWCONTROL

setopt AUTO_NAME_DIRS
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# from oh-my-zsh
# allows completion of imcomplete words
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

autoload -U compinit; compinit

PROMPT='%(1j.%F{blue}[%j]%f.)[%F{cyan}%y%f][%F{green}%~%f]%(?..(%F{red}%?%f%))
%B%n@%m %#%b '

