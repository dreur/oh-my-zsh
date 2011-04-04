## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."

setopt hist_verify
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_reduce_blanks

setopt SHARE_HISTORY
setopt APPEND_HISTORY
