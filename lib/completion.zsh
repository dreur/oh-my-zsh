# fixme - the load process here seems a bit bizarre

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt complete_aliases
setopt always_to_end
setopt list_packed

WORDCHARS=''

zmodload -i zsh/complist

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.oh-my-zsh/cache/

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns adm amanda apache avahi avahi-autoipd backup beagleindex beaglidx bin cacti canna clamav cupsys daemon dbus debian-tor dhcp distcache dnsmasq dovecot fax fetchmail firebird ftp games gdm gkrellmd gnats gopher hacluster haldaemon halt hplip hsqldb ident irc junkbust klog ldap list lp mail mailman mailnull man messagebus mldonkey mysql nagios named netdump news nfsnobody nobody nscd ntp nut nx openvpn operator pcap postfix postgres privoxy proxy pulse pvm quagga radvd rpc rpcuser rpm shutdown snort squid sshd sync sys syslog uucp vcsa www-data xfs
# ... unless we really want to.
zstyle '*' single-ignored show

# use dircolours in completion listings
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Enable menu completion
zstyle ':completion:*:default' menu select
# Give long completion options in a list. tab to advance.
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# allow approximate matching
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' auto-description 'Specify: %d'
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' verbose true
# Separate comand line options and descriptions with #
zstyle ':completion:*' list-separator '#'
# Generate descriptions for arguments

zstyle ':completion:*:complete:*:(functions|parameters|association-keys)' ignored-patterns '_*'
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.(o|c~|zwc)' '*?~'


###
#
# Start completion patterns
#
###

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
# zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:killall:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# only java files for javac
zstyle ':completion:*:javac:*' files '*.java'h

bin_ignore='*.(o|a|so|aux|dvi|swp|fig|bbl|blg|bst|idx|ind|toc|class|pdf|ps|pyc)'
# no binary files for vi or textmate
zstyle ':completion:*:vi:*' ignored-patterns "$bin_ignore"
zstyle ':completion:*:mate:*' ignored-patterns "$bin_ignore"
zstyle ':completion:*:vim:*' ignored-patterns "$bin_ignore"
zstyle ':completion:*:gvim:*' ignored-patterns "$bin_ignore"
# no binary files for less
zstyle ':completion:*:less:*' ignored-patterns "$bin_ignore"
zstyle ':completion:*:zless:*' ignored-patterns "$bin_ignore"
# pdf for xpdf
zstyle ':completion:*:xpdf:*' files '*.pdf'
# tar files
zstyle ':completion:*:tar:*' files '*.tar|*.tgz|*.tz|*.tar.Z|*.tar.bz2|*.tZ|*.tar.gz'
# latex to the fullest
# for printing
zstyle ':completion:*:xdvi:*' files '*.dvi'
zstyle ':completion:*:dvips:*' files '*.dvi'


# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# use /etc/hosts and known_hosts for hostname completion
[ -r /etc/ssh/ssh_known_hosts ] && _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
  "$_global_ssh_hosts[@]"
  "$_ssh_hosts[@]"
  "$_etc_hosts[@]"
  "$HOST"
  localhost
)
zstyle ':completion:*:hosts' hosts $hosts

# this one is very nice:
# cursor up/down look for a command that started like the one starting on the command line
function history-search-end {
    integer ocursor=$CURSOR

    if [[ $LASTWIDGET = history-beginning-search-*-end ]]; then
      # Last widget called set $hbs_pos.
      CURSOR=$hbs_pos
    else
      hbs_pos=$CURSOR
    fi

    if zle .${WIDGET%-end}; then
      # success, go to end of line
      zle .end-of-line
    else
      # failure, restore position
      CURSOR=$ocursor
      return 1
    fi
}
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# some keys
bindkey "\e[A" history-beginning-search-backward #cursor up
bindkey "\e[B" history-beginning-search-forward  #cursor down
#bindkey "\e[A" history-beginning-search-backward-end #cursor up
#bindkey "\e[B" history-beginning-search-forward-end  #cursor down

## dabbrev for zsh!!
zstyle ':completion:history-words:*:history-words' stop yes
zstyle ':completion:history-words:*:history-words' list no
zstyle ':completion:history-words:*' remove-all-dups yes
zstyle ':completion:history-words:*' menu yes
bindkey '\e[15~' _history-complete-older #F5
bindkey '\e[28~' _history-complete-newer #Shift-F5

if [ "x$COMPLETION_WAITING_DOTS" = "xtrue" ]; then
  expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi
