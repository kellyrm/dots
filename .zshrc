alias kssh="kitty +kitten ssh"
alias sudo="sudo --preserve-env=TERMINFO"

export EDITOR=/usr/bin/vim

bindkey -v
bindkey -a "h" vi-backward-char
bindkey -a "t" down-line-or-history
bindkey -a "n" up-line-or-history
bindkey -a "s" vi-forward-char
bindkey -a "l" vi-repeat-search
bindkey -a "L" vi-rev-repeat-search

autoload -U compinit; compinit

PROMPT='%(1j.%F{blue}[%j]%f.)[%F{cyan}%y%f][%F{green}%~%f]%(?..(%F{red}%?%f%))
%B%n@%m %#%b '
