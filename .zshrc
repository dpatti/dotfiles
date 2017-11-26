[ -f ~/.zprezto/init.zsh ] && source ~/.zprezto/init.zsh

source ~/.commonrc

alias -g L='|& less'
alias -g .log='$(git log --reverse --pretty=oneline --abbrev-commit -20 | fzf +s --prompt="fixup> " | awk ''{ print $1 }'')'

unsetopt nomatch
unsetopt share_history

bindkey '^U' backward-kill-line

fzf-git-branch-widget() {
  LBUFFER="${LBUFFER}$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads | fzf)"
  zle redisplay
}
zle -N fzf-git-branch-widget
bindkey '^B' fzf-git-branch-widget

fzf-executable-widget() {
  (($#)) || set ''
  LBUFFER="${LBUFFER}$(print -lr -- $^path/*$^@*(N:t) | sort -u | fzf)"
  zle redisplay
}
zle -N fzf-executable-widget
bindkey '^X' fzf-executable-widget

source-if-exists ~/.fzf.zsh

function reset {
  command reset && source ~/.zshrc
}
