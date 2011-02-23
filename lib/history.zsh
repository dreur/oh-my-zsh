## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."

setopt hist_ignore_dups # ignore duplication command history list

setopt hist_verify
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_space

setopt SHARE_HISTORY
setopt APPEND_HISTORY
