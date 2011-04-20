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
