function extract() {
    unset REMOVE_ARCHIVE
    
    if test "$1" = "-r"; then
        REMOVE=1
        shift
    fi
  if [[ -f $1 ]]; then
    case $1 in
      *.tar.bz2) tar xvjf $1;;
      *.tar.gz) tar xvzf $1;;
      *.tar.xz) tar xvJf $1;;
      *.tar.lzma) tar --lzma -xvf $1;;
      *.bz2) bunzip $1;;
      *.rar) unrar $1;;
      *.gz) gunzip $1;;
      *.tar) tar xvf $1;;
      *.tbz2) tar xvjf $1;;
      *.tgz) tar xvzf $1;;
      *.zip) unzip $1;;
      *.Z) uncompress $1;;
      *.7z) 7z x $1;;
      *) echo "'$1' cannot be extracted via >extract<";;
    esac

    if [[ $REMOVE_ARCHIVE -eq 1 ]]; then
        echo removing "$1";
        /bin/rm "$1";
    fi

  else
    echo "'$1' is not a valid file"
  fi
}

gztardir()
{
  if [ $# -ne 1 ] ; then
    echo "incorrect arguments: should be gztardir <dir>"
  else
    tar cvf - $1 | gzip > $1.tar.gz
      fi
}

gzuntar()
{
  if [ $# -ne 1 ] ; then
    echo "gzuntar: incorrect arguments"
  else
    gunzip -c $1 | tar xvf -
      fi
}

gzlooktar()
{
  if [ $# -ne 1 ] ; then
    echo "gzlooktar: incorrect arguments"
  else
    gunzip -c $1 | tar tvf -
      fi
}

gztardir_all()
{
  if [ $# -ne 1 ] ; then
    echo "gztardir_all: need the home dir"
  else
    for i in $( ls ); do  echo `basename $i`; gztardir $i;  done;
  fi
}
