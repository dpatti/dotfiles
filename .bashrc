# Common parameters
alias ls='ls -v --color=tty'
alias ll='ls -l --all --human-readable'
alias grep='grep --color --binary-files=without-match --line-number --exclude=*.orig'
alias server='python -m SimpleHTTPServer'
alias diff='colordiff'
alias less='less --quit-if-one-screen --no-init --raw-control-chars'
alias sagi='sudo apt-get install'
alias ..='cd ..'
alias mocha='mocha --reporter dot --compilers coffee:coffee-script --colors'

# I just enjoy this
function say { mplayer "http://translate.google.com/translate_tts?tl=en&q=$*" >/dev/null 2>&1; }

# PATH augmentation
PATH=$HOME/bin:$PATH      # Local scripts

# Interactive-only commands below
[ -z "$PS1" ] && return

function prompt {
  local code="\$(if [ \$? = 0 ]; then echo -e \"\[\033[0;36m\]\$\"; else echo -e \"\[\033[0;31m\]\$\"; fi)"
  local userhost="\[\033[0;36m\]\u@\h"
  local cwd="\w"
  # local git="\[\033[0;33m\]\$(read b 2>/dev/null <.git/HEAD && ([[ \$b < g ]] && echo \(\${b::7}\) || echo \(\${b##*/}\)))"
  export PS1="$userhost:$cwd$code \[\033[0m\]"
}
prompt

# Up and down search based on what was typed in so far
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Case insensitive matching
shopt -s nocaseglob

HISTSIZE=5000
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
