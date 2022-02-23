alias kssh="kitty +kitten ssh"
alias sudo="sudo --preserve-env=TERMINFO"
bindkey -v

PROMPT='%(1j.%F{blue}[%j]%f.)[%F{cyan}%y%f][%F{green}%~%f]
%(?..(%F{red}%?%f%) )%B%n@%m %%%b '
