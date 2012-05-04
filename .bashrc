# Common parameters
alias ls='ls -v --color=tty'
alias ll='ls -val'
alias grep='grep --color -I'
alias ssh='ssh -t -t' # Something about stdin not being a terminal when I use OpenSSH on mintty?
alias server='python -m SimpleHTTPServer'
alias diff='colordiff'

# Up and down search based on what was typed in so far
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Case insensitive matching
shopt -s nocaseglob
