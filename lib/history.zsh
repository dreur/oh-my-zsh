## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd..:ls -la"

setopt hist_verify
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt hist_allow_clobber

#setopt SHARE_HISTORY

# Grep the history with 'h'
h () { history 0 | grep $1 }
