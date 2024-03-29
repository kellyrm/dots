[ -f ~/.localenv ] && source ~/.localenv

if [ -z "$LOCALENV_NOAGENT" ] ; then
    SSH_AGENT_ENV=$HOME/.config/ssh-agent.env
    source $SSH_AGENT_ENV > /dev/null

    if [ -z "$SSH_AGENT_PID" ] || ! pgrep -u `whoami` -x ssh-agent > /dev/null ; then
        pgrep -u `whoami` -x ssh-agent | xargs kill -KILL 2&>1 > /dev/null
        eval $(ssh-agent | tee $SSH_AGENT_ENV)
    fi
fi

alias kty='i3-msg "exec --no-startup-id kitty -1 --instance-group i3 group0 -d $(pwd)"'

alias kssh="kitty +kitten ssh"
alias sudo="sudo --preserve-env=TERMINFO"
alias ls="ls --color=auto"
alias less="less -i"
alias ec="emacsclient -t"
alias emacs="emacs -nw"
alias st-prog="st-flash --format ihex write"

export EDITOR=/usr/bin/vim

bindkey -M viopp "h" vi-backward-char
bindkey -M viopp "t" down-line-or-history
bindkey -M viopp "n" up-line-or-history
bindkey -M viopp "s" vi-forward-char
bindkey -M viopp "l" vi-repeat-search
bindkey -M viopp "L" vi-rev-repeat-search
bindkey -M viopp "k" vi-find-next-char-skip
bindkey -M viopp "K" vi-find-prev-char-skip
bindkey -v
bindkey -a "h" vi-backward-char
bindkey -a "t" down-line-or-history
bindkey -a "n" up-line-or-history
bindkey -a "s" vi-forward-char
bindkey -a "l" vi-repeat-search
bindkey -a "L" vi-rev-repeat-search
bindkey -a "k" vi-find-next-char-skip
bindkey -a "K" vi-find-prev-char-skip

# allow :w
zle -A accept-line w
zle -A accept-line x

setopt HIST_IGNORE_ALL_DUPS
setopt AUTO_CD

# completion
unsetopt MENU_COMPLETE
unsetopt FLOWCONTROL

# setopt AUTO_NAME_DIRS
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# from oh-my-zsh
# allows completion of imcomplete words
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

autoload -U compinit; compinit

[ -z $HOST_COLOR ] && HOST_COLOR=white

PROMPT="%(1j.%F{blue}[%j]%f.)[%F{cyan}%y%f][%F{green}%~%f]%(?..(%F{red}%?%f%))
%B%n@%F{$HOST_COLOR}%m%f %#%b "

[ "$USER" = "root" ] && [ "$(stat -c %d:%i /)" != "$(stat -c %d:%i /proc/1/root/.)" ] && export CHROOT=yes

[ -z $CHROOT ] || PROMPT="[%F{red}chroot%f]$PROMPT"

