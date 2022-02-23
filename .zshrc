alias kssh="kitty +kitten ssh"
bindkey -v

PROMPT='%(1j.%F{blue}[%j]%f.)[%F{cyan}%y%f][%F{green}%~%f]
%(?..(%F{red}%?%f%) )%B%n@%m %%%b '
