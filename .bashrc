alias ll='ls -l'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
shopt -s nocaseglob

# Something about stdin not being a terminal when I use OpenSSH on mintty?
alias ssh='ssh -t -t'
