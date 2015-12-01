# Archlinux zsh aliases and functions
# Usage is also described at https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins

# Look for yaourt, and add some useful functions if we have it.
if [[ -x `which yaourt` ]]; then
  upgrade () {
    yaourt -Syu
  }
  alias yaconf='yaourt -C'        # Fix all configuration files with vimdiff
  # Pacman - https://wiki.archlinux.org/index.php/Pacman_Tips
  alias yaupg='yaourt -Syu'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
  alias yasu='yaourt --sucre'      # Same as yaupg, but without confirmation
  alias yain='yaourt -S'           # Install specific package(s) from the repositories
  alias yains='yaourt -U'          # Install specific package not from the repositories but from a file
  alias yare='yaourt -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
  alias yarem='yaourt -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
  alias yarep='yaourt -Si'         # Display information about a given package in the repositories
  alias yareps='yaourt -Ss'        # Search for package(s) in the repositories
  alias yaloc='yaourt -Qi'         # Display information about a given package in the local database
  alias yalocs='yaourt -Qs'        # Search for package(s) in the local database
  # Additional yaourt alias examples
  if [[ -x `which abs` ]]; then
    alias yaupd='yaourt -Sy && sudo abs'   # Update and refresh the local package and ABS databases against repositories
  else
    alias yaupd='yaourt -Sy'               # Update and refresh the local package and ABS databases against repositories
  fi
  alias yainsd='yaourt -S --asdeps'        # Install given package(s) as dependencies of another package
  alias yainse='yaourt -D --asexplicit'    # Install given package(s) as explicit - It won't show as an orphan
  alias yamir='yaourt -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist
else
 upgrade() {
   sudo pacman -Syu
 }
fi

# Pacman - https://wiki.archlinux.org/index.php/Pacman_Tips
alias pacupg='sudo pacman -Syu'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
alias pacin='sudo pacman -S'           # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'          # Install specific package not from the repositories but from a file
alias pacre='sudo pacman -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'              # Display information about a given package in the repositories
alias pacreps='pacman -Ss'             # Search for package(s) in the repositories
alias pacloc='pacman -Qi'              # Display information about a given package in the local database
alias paclocs='pacman -Qs'             # Search for package(s) in the local database
# Additional pacman alias examples
if [[ -x `which abs` ]]; then
  alias pacupd='sudo pacman -Sy && sudo abs'     # Update and refresh the local package and ABS databases against repositories
else
  alias pacupd='sudo pacman -Sy'     # Update and refresh the local package and ABS databases against repositories
fi
alias pacinsd='sudo pacman -S --asdeps'        # Install given package(s) as dependencies of another package
alias pacinse='sudo pacman -D --asexplicit'    # Install given package(s) as explicit - It won't show as an orphan
alias pacmir='sudo pacman -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

# https://bbs.archlinux.org/viewtopic.php?id=93683
paclist() {
  sudo pacman -Qei $(pacman -Qu|cut -d" " -f 1)|awk ' BEGIN {FS=":"}/^Name/{printf("\033[1;36m%s\033[1;37m", $2)}/^Description/{print $2}'
}

alias paclsorphans='sudo pacman -Qdt' # Use paxinse or yainse to install explicitly
alias pacrmorphans='sudo pacman -Rs $(pacman -Qtdq)'

pacdisowned() {
  tmp=${TMPDIR-/tmp}/pacman-disowned-$UID-$$
  db=$tmp/db
  fs=$tmp/fs

  mkdir "$tmp"
  trap  'rm -rf "$tmp"' EXIT

  pacman -Qlq | sort -u > "$db"

  find /bin /etc /lib /sbin /usr \
      ! -name lost+found \
        \( -type d -printf '%p/\n' -o -print \) | sort > "$fs"

  comm -23 "$fs" "$db"
}

# Journal control (journalctl) aliases
# Disable it by setting ZSH_JOURNALCTL to false
if [ -z $ZSH_JOURNALCTL ] || [ $ZSH_JOURNALCTL ]; then
	alias ju="sudo journalctl -eu"         # Show some unit's journal
	alias jfu="sudo journalctl -feu"       # Follow some unit's journal
fi

# Network control (netctl) aliases
# Disable it by setting ZSH_NETCTL to false
if [ -z $ZSH_NETCTL ] || [ $ZSH_NETCTL ]; then
	alias nc-l="netctl list"               # Show network profiles list
	alias nc-s="netctl status"             # Show a profile's status
	alias nc-ed="sudo netctl edit"              # Edit a profile
	alias nc-eb="sudo netctl enable"            # Enable a profile
	alias nc-db="sudo netctl disable"           # Disable a profile
	alias nc-rst="sudo netctl restart"          # etc ...
	alias nc-st="sudo netctl start"
	alias nc-sp="sudo netctl stop"
	alias nc-spa="sudo netctl stop-all"
	alias nc-swt="sudo netctl switch-to"
fi

# System control (systemctl) aliases
# Disable it by setting ZSH_SYSTEMCTL to false
if [ -z $ZSH_SYSTEMCTL ] || [ $ZSH_SYSTEMCTL ]; then
	alias sc-po="sudo systemctl poweroff"  # Shut-down and poweroff the system
	alias sc-rb="sudo systemctl reboot"    # Shut-down and reboot the system

	# Units control
	alias sc-ex="sudo systemctl exit"      # Ask for user instance termination
	alias sc-ed="sudo systemctl edit"      # Edit unit's config
	alias sc-eb="sudo systemctl enable"    # Enable a unit
	alias sc-db="sudo systemctl disable"   # Disable
	alias sc-s="sudo systemctl status"     # I guess you understand the rest :)
	alias sc-sp="sudo systemctl stop"
	alias sc-st="sudo systemctl start"
	alias sc-sw="sudo systemctl show"
	alias sc-rl="sudo systemctl reload"
	alias sc-rst="sudo systemctl rstart"
	alias sc-k="sudo systemctl kill"
	alias sc-c="sudo systemctl cancel"
fi
