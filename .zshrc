[ -f ~/.zprezto/init.zsh ] && source ~/.zprezto/init.zsh

source ~/.commonrc

alias -g L='|& less'
alias -g bb='$(git branch | fzf +s +m)'
alias -g .log='$(git log --reverse --pretty=oneline --abbrev-commit -20 | fzf +s --prompt="fixup> " | awk ''{ print $1 }'')'

unsetopt nomatch
unsetopt share_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
