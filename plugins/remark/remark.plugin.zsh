# Log colorizer
# @see http://www.nongnu.org/regex-markup/
# Other example can be taken from the example folder
#
# Usage: logview $ZSH/plugins/remark/examples/syslog /var/log/syslog

# TODO Improve to kill jobs when remark find an error in the files
function logview() {
  templogfile=$(mktemp)

  tail -n -10 --follow=name "$2" | remark "$1" >! $templogfile &
  pidRemark=$!

  less -R +F $templogfile
  kill $pidRemark &> /dev/null
}

function logview_debug() {
remark "$1" < "$2"
}
