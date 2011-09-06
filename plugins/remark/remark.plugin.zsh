# Log colorizer
# @see http://www.nongnu.org/regex-markup/
# Other example can be taken from the example folder
#
# Usage: logview $ZSH/plugins/remark/examples/syslog /var/log/syslog
# Usage: logtail $ZSH/plugins/remark/examples/syslog /var/log/syslog

# TODO Improve to kill jobs when remark find an error in the files
function logview() {
  #if [ $? == 3 ]; then
  #  if [ "x${$3}" != "x" ]; then
  #    less -R +F "${$3}"
  #    exit
  #  fi
  #fi
  templogfile=$(mktemp)

  (tail -n +0 --follow=name "$2" | remark "$1" >! $templogfile) &
  pidRemark=$!

  less -R +F $templogfile
  kill $pidRemark &> /dev/null
}

function logtail() {
  templogfile=$(mktemp)

  (tail -n -100 --follow=name "$2" | remark "$1" >! $templogfile) &
  pidRemark=$!

  less -R +F $templogfile
  kill $pidRemark &> /dev/null
}

function logview_debug() {
  remark "$1" < "$2"
}
