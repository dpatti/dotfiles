# Common parameters
alias ls='ls -v --color=tty'
alias ll='ls -l --all --human-readable'
alias cgrep='grep --color --binary-files=without-match --line-number --exclude=*.orig'
alias server='python -m SimpleHTTPServer'
alias diff='colordiff'
alias sagi='sudo apt-get install'
alias ..='cd ..'
alias ci='cabal install --disable-documentation --disable-executable-profiling --disable-library-coverage --disable-benchmarks --disable-library-profiling -j'
alias dgit='git --git-dir ~/dotfiles/.git'
alias qgit='git'

LESS='--quit-if-one-screen --no-init --RAW-CONTROL-CHARS --ignore-case --LONG-PROMPT --chop-long-lines --tabs=2'
HISTSIZE=5000

# PATH augmentation
PATH=$HOME/bin:$PATH
PATH=$HOME/.rvm/bin:$PATH
PATH=$HOME/.cabal/bin:$PATH

# For easy directory probing -- combines ls and cat depending on the argument
function p {
  code=0

  if [ $# -eq 0 ]; then
    ls
    return
  fi

  for arg in $@; do
    if [ -d "$arg" ]; then
      ls $arg
    elif [ -f "$arg" ]; then
      cat $arg
    else
      echo "Not a directory or file: $arg" >&2
      code=1
    fi
  done
  return $code
}

# Test upstream and downstream bandwidth to a vps
function upstream { cat /dev/zero | pv | ssh $@ 'cat > /dev/null'; }
function downstream { ssh $@ 'cat /dev/zero' | pv | cat > /dev/null; }

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

# Case insensitive matching
shopt -s nocaseglob
