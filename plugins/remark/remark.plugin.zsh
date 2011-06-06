# Log colorizer
# @see http://www.nongnu.org/regex-markup/
# Other example can be taken from the example folder
#
# Usage: logview $ZSH/plugins/remark/examples/syslog /var/log/syslog

# TODO Improve to kill jobs when remark find an error in the files
function logview() {
  templogfile=`mktemp`

  tail -n +0 --follow=name "$2" | remark "$1" > $templogfile &
  pidRemark=$!

  #if [ $? -ne 0 ]; then
  #  kill $pidRemark &> /dev/null
  #  exit 1
  #fi

  less -R +F $templogfile
  kill $pidRemark &> /dev/null
}
