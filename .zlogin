# .zlogin is sourced for login shells: .zshenv -> .zprofile -> .zshrc -> [.zlogin]

# Asynchronously compile the completion dump assuming `compinit` was called
{
  zcompdump="$HOME/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# ------------------------------------------------------------------------------

# Profile if loaded at the start of the file
if (( ${+modules[zsh/zprof]} )); then zprof; fi
