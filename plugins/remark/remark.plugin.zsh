
function logview() {
  templogfile=`mktemp`

  tail -n +0 --follow=name "$2" | remark "$1" > $templogfile &
  pidRemark=$!

  less -R +F $templogfile
  kill $pidRemark
}
