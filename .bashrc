source ~/.commonrc

alias ..='cd ..'

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
