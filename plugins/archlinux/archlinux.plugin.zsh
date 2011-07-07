# Archlinux zsh aliases and functions for zsh

# Aliases ###################################################################

# Look for yaourt, and add some useful functions if we have it.
if [[ -x `which yaourt` ]]; then
  upgrade () {
    yaourt -Syu -C
  }
  alias ys='yaourt -S' # Sync
  alias ysy='yaourt -Sy' # Refresh
  alias ysyu='yaourt -Syu' # Refresh upgrade
  alias yc='yaourt -C' # Merge pacnew
  alias yss='yaourt -Ss' # Search
  alias yr='yaourt -Rs' # Remove recursively keeping config
  alias yrn='yaourt -Rcsn' # Remove recursively without saving config
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
# https://bbs.archlinux.org/viewtopic.php?id=93683
paclist() {
  sudo pacman -Qei $(pacman -Qu|cut -d" " -f 1)|awk ' BEGIN {FS=":"}/^Name/{printf("\033[1;36m%s\033[1;37m", $2)}/^Description/{print $2}'
}
alias pac_lsorhpans='sudo pacman -Qdt'
alias pac_rmorphans='sudo pacman -Rs $(pacman -Qtdq)'
