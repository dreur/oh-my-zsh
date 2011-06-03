# ZSH Theme emulating the Fish shell's default prompt.

ZSH_PROMPT_BASE_COLOR="%{$fg_bold[blue]%}"

local user_color='green'; [ $UID -eq 0 ] && user_color='red'
PROMPT='%n@%{$FX[underline]%}%m%{$reset_color%} %{$fg[$user_color]%}%~%{$reset_color%}%(!.#.>) '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

local return_status="%{$fg_bold[red]%}%(?..%?)%{$reset_color%}"
RPROMPT='${return_status}$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} added"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} modified"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} deleted"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} renamed"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} unmerged"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} untracked"
