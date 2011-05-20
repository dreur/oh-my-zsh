
function logview() {
  templogfile=`mktemp`

  tail -n +0 --follow=name "$1" | remark /usr/share/regex-markup/syslog > $templogfile &
  pidRemark=$!

  less -R +F $templogfile
  kill $pidRemark
}
