# Archlinux zsh aliases and functions for zsh

# Aliases ###################################################################

# Look for yaourt, and add some useful functions if we have it.
if [[ -x `which yaourt` ]]; then
  upgrade () {
    yaourt -Syu -C
  }
  alias ys='yaourt -S' # Sync
  alias ysy='yaourt -Sy' # Refresh
  alias ysyu='yaourt -Syu -C' # Refresh upgrade
  alias yss='yaourt -Ss' # Search
  alias yr='yaourt -Rs' # Remove recursively keeping config
  alias yrn='yaourt -Rsn' # Remove recursively without saving config
else
 upgrade() {
   sudo pacman -Syu
 }
fi

# Pacman:
alias pacman='sudo pacman'
alias pacs='sudo pacman -S'
alias pacsy='sudo pacman -Sy'
alias pacsyu='sudo pacman -Syu'
alias pacss='sudo pacman -Ss'
alias pacr='sudo pacman -Rs'
alias pacsc='sudo pacman -Sc'
