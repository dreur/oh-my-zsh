# Log colorizer
# @see http://www.nongnu.org/regex-markup/
# Other example can be taken from the example folder
#
# Usage: logview $ZSH/plugins/remark/examples/syslog /var/log/syslog


function logview() {
  templogfile=`mktemp`

  tail -n +0 --follow=name "$2" | remark "$1" > $templogfile &
  pidRemark=$!

  less -R +F $templogfile
  kill $pidRemark
}
