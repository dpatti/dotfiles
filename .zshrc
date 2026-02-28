# Uncomment to profile
# zmodload zsh/zprof

# Plugins ----------------------------------------------------------------------

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ -d $ZINIT_HOME ] && source "${ZINIT_HOME}/zinit.zsh"

zinit load 'zsh-users/zsh-syntax-highlighting'
zinit load 'zsh-users/zsh-autosuggestions'
zinit load 'zsh-users/zsh-history-substring-search'
zinit load 'mafredri/zsh-async'

zinit ice src'pure.zsh'
zinit load 'dpatti/pure'

# fzf comes packaged in the binary
(( ${+commands[fzf]} )) && source <(fzf --zsh)

# Config -----------------------------------------------------------------------

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# pure
zstyle ':prompt:pure:prompt:success' color green

# General ----------------------------------------------------------------------

source ~/.commonrc

setopt AUTO_CD               # cd without `cd`
setopt INTERACTIVE_COMMENTS  # Allow comments in interactive
setopt NO_CLOBBER            # Don't clobber files with redirections
setopt RC_QUOTES             # Two single quotes escape in a single-quoted string
setopt LONG_LIST_JOBS        # Print more info when jobs complete

WORDCHARS='_-'

bindkey -A emacs main

# Ctrl+Left / Ctrl+Right
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

# Ctrl+F is forward-word for accepting partial suggestions
bindkey '^F' forward-word

# Ctrl+U to kill line before cursor instead of whole line
bindkey '^U' backward-kill-line

# Completion -------------------------------------------------------------------

autoload -U compinit
compinit

setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.
setopt AUTO_MENU           # Show completion menu on a successive tab press.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB       # Needed for file modification glob modifiers with compinit
setopt MENU_COMPLETE       # Autoselect the first completion entry.
unsetopt FLOW_CONTROL      # Disable start/stop characters in shell editor.

zstyle ':completion:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Use caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zcompcache"

bindkey '^[[Z' reverse-menu-complete # Shift+Tab to cycle backwards

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

# Up / Down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Aliases ----------------------------------------------------------------------

alias -g L='|& less'
alias -g .log='$(git log --reverse --pretty=oneline --abbrev-commit -20 | fzf +s --prompt="fixup> " | awk ''{ print $1 }'')'
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
  export FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore"
  LBUFFER="${LBUFFER}$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads | fzf)"
  zle redisplay
}
zle -N fzf-git-branch-widget
bindkey '^B' fzf-git-branch-widget

# Ctrl+X: fzf path executable selector
fzf-executable-widget() {
  export FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore"
  (($#)) || set ''
  LBUFFER="${LBUFFER}$(print -lr -- $^path/*$^@*(N:t) | sort -u | fzf)"
  zle redisplay
}
zle -N fzf-executable-widget
bindkey '^X' fzf-executable-widget

# ------------------------------------------------------------------------------

# Profile if loaded at the start of the file
(( ${+modules[zsh/zprof]} )) && zprof
