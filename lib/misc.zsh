## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## file rename magick
bindkey "^[m" copy-prev-shell-word

## Scripting options
# setopt MULTIOS

## jobs
setopt long_list_jobs
setopt NO_HUP
setopt CHECK_JOBS

## pager
export PAGER=less

# Better safe than sorry
setopt RM_STAR_WAIT
export LC_CTYPE=$LANG
