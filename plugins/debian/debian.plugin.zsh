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

function apt-history(){
  case "$1" in
    install)
      cat /var/log/dpkg.log | grep 'install '
      ;;
    upgrade|remove)
      cat /var/log/dpkg.log | grep $1
      ;;
    rollback)
      cat /var/log/dpkg.log | grep upgrade | \
        grep "$2" -A10000000 | \
        grep "$3" -B10000000 | \
        awk '{print $4"="$5}'
      ;;
    *)
      cat /var/log/dpkg.log
      ;;
  esac
}
