# Plugins ----------------------------------------------------------------------

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ -d $ZINIT_HOME ] && source "${ZINIT_HOME}/zinit.zsh"

zinit load 'zsh-users/zsh-syntax-highlighting'
zinit load 'zsh-users/zsh-autosuggestions'
zinit load 'zsh-users/zsh-history-substring-search'
zinit load 'Aloxaf/fzf-tab'
zinit load 'mafredri/zsh-async'

zinit ice pick'async.zsh' src'pure.zsh'
zinit load 'sindresorhus/pure'

# fzf comes packaged in the binary
(( ${+commands[fzf]} )) && source <(fzf --zsh)

# zinit autoloads the `colors` function
unfunction colors

# Config -----------------------------------------------------------------------

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# pure
zstyle ':prompt:pure:prompt:success' color green
zstyle ':prompt:pure:suspended_jobs' color magenta

# Add OSC 133 support
PS1=$'%{\e]133;A\e\\%}'$PS1$'%{\e]133;B\e\\%}'
function __osc133_preexec {
  printf '\e]133;C\e\\'
}
typeset -a preexec_functions
preexec_functions+=(__osc133_preexec)

# General ----------------------------------------------------------------------

source ~/.commonrc

setopt AUTO_CD               # cd without `cd`
setopt INTERACTIVE_COMMENTS  # Allow comments in interactive
setopt NO_CLOBBER            # Don't clobber files with redirections
setopt RC_QUOTES             # Two single quotes escape in a single-quoted string
setopt LONG_LIST_JOBS        # Print more info when jobs complete

WORDCHARS='_-'

bindkey -A emacs main

# Adapted from https://wiki.archlinux.org/title/Zsh#Key_bindings
# create a zkbd compatible hash (see man 5 terminfo)
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# (these print errors if the terminfo doesn't exist, e.g., for TERM=linux)
bindkey -- "${key[Home]}"          beginning-of-line
bindkey -- "${key[End]}"           end-of-line
bindkey -- "${key[Insert]}"        overwrite-mode
bindkey -- "${key[Backspace]}"     backward-delete-char
bindkey -- "${key[Delete]}"        delete-char
bindkey -- "${key[Up]}"            history-substring-search-up
bindkey -- "${key[Down]}"          history-substring-search-down
bindkey -- "${key[Left]}"          backward-char
bindkey -- "${key[Right]}"         forward-char
bindkey -- "${key[Control-Left]}"  emacs-backward-word
bindkey -- "${key[Control-Right]}" emacs-forward-word
bindkey -- "${key[PageUp]}"        beginning-of-buffer-or-history
bindkey -- "${key[PageDown]}"      end-of-buffer-or-history
bindkey -- "${key[Shift-Tab]}"     reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
  autoload -Uz add-zle-hook-widget
  function zle_application_mode_start { echoti smkx }
  function zle_application_mode_stop { echoti rmkx }
  add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
  add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Ctrl+F is forward-word for accepting partial suggestions
bindkey '^F' forward-word

# Ctrl+U to kill line before cursor instead of whole line
bindkey '^U' backward-kill-line

# Completion -------------------------------------------------------------------

autoload -Uz compinit
compinit

setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
# (what did this comment mean?)
# setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit
unsetopt EXTENDED_GLOB     # Don't treat #, ~, and ^ as glob patterns
setopt MENU_COMPLETE       # Autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.

if (( $zsh_loaded_plugins[(Ie)Aloxaf/fzf-tab] )); then
  zstyle ':completion:*' menu no
  # Uncomment for group support
  # zstyle ':completion:*:descriptions' format '[%d]'
  # zstyle ':fzf-tab:*' switch-group '<' '>'
else
  zstyle ':completion:*' menu select
  zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
  zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
fi

zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Use caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zcompcache"

# History ----------------------------------------------------------------------

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
unsetopt SHARE_HISTORY           # Multiple terminals shouldn't mix history.
setopt INC_APPEND_HISTORY        # But we want to flush history every command.
setopt AUTO_CD

HISTFILE="$HOME/.zhistory"
HISTSIZE=50000                   # The maximum number of events to save in the internal history.
SAVEHIST=$HISTSIZE               # The maximum number of events to save in the history file.

# Aliases ----------------------------------------------------------------------

alias s='source ~/.zshrc'

# Special keybindings ----------------------------------------------------------

# Ctrl+Z: toggle between suspend and resume
function bg-resume {
  fg
  zle push-input
  BUFFER=""
  zle accept-line
}
zle -N bg-resume
bindkey '^Z' bg-resume

# Ctrl+B: fzf git branch selector
fzf-git-branch-widget() {
  LBUFFER="${LBUFFER}$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads | $(__fzfcmd))"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle -N fzf-git-branch-widget
bindkey '^B' fzf-git-branch-widget

# Ctrl+X: fzf path executable selector
fzf-executable-widget() {
  (($#)) || set ''
  LBUFFER="${LBUFFER}$(print -lr -- $^path/*$^@*(N:t) | sort -u | $(__fzfcmd))"
  zle reset-prompt
  return $ret
}
zle -N fzf-executable-widget
bindkey '^X' fzf-executable-widget
