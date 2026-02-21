# .zprofile is sourced for login shells: .zshenv -> [.zprofile] -> .zshrc -> .zlogin

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path
