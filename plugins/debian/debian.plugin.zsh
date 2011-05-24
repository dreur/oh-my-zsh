# https://github.com/dbbolton/
#
# Debian-related zsh aliases and functions for zsh

# Aliases ###################################################################

# Look for apt, and add some useful functions if we have it.
if [[ -x `which apt-get` ]]; then
  alias apt-get='noglob sudo apt-get'
  alias aptitude='noglob sudo aptitude'

  upgrade () {
  	if [ -z $1 ] ; then
  		sudo apt-get update
  		sudo apt-get -u upgrade
  	else
  		ssh $1 sudo apt-get update
  		# ask before the upgrade
  		local dummy
  		ssh $1 sudo apt-get --no-act upgrade
  		echo -n "Process the upgrade ?"
  		read -q dummy
  		if [[ $dummy == "y" ]] ; then
  			ssh $1 sudo apt-get -u upgrade --yes
  		fi
  	fi
  }
fi

# Some self-explanatory aliases
alias afs='apt-file search --regexp'
alias aps='aptitude search'
alias apsrc='apt-get source'
alias apv='apt-cache policy'

alias apdg='su -c "aptitude update && aptitude safe-upgrade"'
alias apud='su -c "aptitude update"'
alias apug='su -c "aptitude safe-upgrade"'

# print all installed packages
alias allpkgs='aptitude search -F "%p" --disable-columns ~i'

# Install all .deb files in the current directory.
# Warning: you will need to put the glob in single quotes if you use:
# glob_subst
alias di='su -c "dpkg -i ./*.deb"'

# Create a basic .deb package
alias mydeb='time dpkg-buildpackage -rfakeroot -us -uc'

# Remove ALL kernel images and headers EXCEPT the one in use
alias kclean='su -c '\''aptitude remove -P ?and(~i~nlinux-(ima|hea) ?not(~n`uname -r`))'\'' root'



# Functions #################################################################

# create a simple script that can be used to 'duplicate' a system
apt-copy() {
	print '#!/bin/sh'"\n" > apt-copy.sh

	list=$(perl -m'AptPkg::Cache' -e '$c=AptPkg::Cache->new; for (keys %$c){ push @a, $_ if $c->{$_}->{'CurrentState'} eq 'Installed';} print "$_ " for sort @a;')

	print 'aptitude install '"$list\n" >> apt-copy.sh

	chmod +x apt-copy.sh
}

### Based On:
### http://linuxcommando.blogspot.com/2008/08/how-to-show-apt-log-history.html
function apt-history(){
  case "$1" in
    install)
      zgrep --no-filename 'install ' $(ls -rt /var/log/dpkg*)
      ;;
    upgrade|remove)
      zgrep --no-filename $1 $(ls -rt /var/log/dpkg*)
      ;;
    rollback)
      zgrep --no-filename upgrade $(ls -rt /var/log/dpkg*) | \
        grep "$2" -A10000000 | \
        grep "$3" -B10000000 | \
        awk '{print $4"="$5}'
      ;;
    list)
      zcat $(ls -rt /var/log/dpkg*)
      ;;
    *)
      echo "Parameters:"
      echo " install - Lists all packages that have been installed."
      echo " upgrade - Lists all packages that have been upgraded."
      echo " remove - Lists all packages that have been removed."
      echo " rollback - Lists rollback information."
      echo " list - Lists all contains of dpkg logs."
      ;;
  esac
}

# Kernel-package building shortcut
dbb-build () {
	MAKEFLAGS=''		# temporarily unset MAKEFLAGS ( '-j3' will fail )
	appendage='-custom' # this shows up in $ (uname -r )
    revision=$(date +"%Y%m%d") # this shows up in the .deb file name

    make-kpkg clean

    time fakeroot make-kpkg --append-to-version "$appendage" --revision \
        "$revision" kernel_image kernel_headers
}