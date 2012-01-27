# Common parameters
alias ls='ls --color=tty'
alias ll='ls -al'
alias grep='grep --color'
alias ssh='ssh -t -t' # Something about stdin not being a terminal when I use OpenSSH on mintty?

# Up and down search based on what was typed in so far
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Case insensitive matching
shopt -s nocaseglob


