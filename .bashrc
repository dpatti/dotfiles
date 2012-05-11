# Common parameters
alias ls='ls -v --color=tty'
alias ll='ls -val'
alias grep='grep --color -I'
alias ssh='ssh -t -t' # Something about stdin not being a terminal when I use OpenSSH on mintty?
alias server='python -m SimpleHTTPServer'
alias diff='colordiff'
alias gvim='gvim -f &'
alias gvima='gvim --remote-silent'

# PATH augmentation
PATH=$HOME/bin:$PATH      # Local scripts

# Interactive-only commands below
[ -z "$PS1" ] && return

PS1="\[\033[0;36m\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$\[\033[0m\] "

# Up and down search based on what was typed in so far
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Case insensitive matching
shopt -s nocaseglob

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
