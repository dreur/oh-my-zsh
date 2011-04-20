## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## file rename magick
bindkey "^[m" copy-prev-shell-word

## Scripting options
setopt MULTIOS

## jobs
setopt long_list_jobs
setopt NO_HUP
setopt CHECK_JOBS

## pager
export PAGER=less
export LC_CTYPE=en_US.UTF-8

# Better safe than sorry
setopt RM_STAR_WAIT
