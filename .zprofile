# .zprofile is sourced for login shells: .zshenv -> [.zprofile] -> .zshrc -> .zlogin

# Uncomment to profile
# zmodload zsh/zprof

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path
