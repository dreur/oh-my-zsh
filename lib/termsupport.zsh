# From: http://dotfiles.org/~_why/.zshrc
# Really works with minimal prompt setup.

# format titles for screen and rxvt
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\"      # screen title (in ^A")
    ;;
  xterm*|rxvt|ansi)    
    print -Pn "\e]1;$2 | $a:$3\a" # plain xterm title
    print -Pn "\e]2;$2 | $a:$3\a" # tab title
    ;;
  esac
}

# precmd is called just before the prompt is printed
function precmd() {
  # This loads the info messgage into %1v.
  title "zsh" "$USER@%m" "%55<...<%~"
}

# preexec is called just before any command line is executed
function preexec() {
  title "$1" "$USER@%m" "%35<...<%~"
}

#case "$TERM" in
#  xterm*|rxvt*)
#    preexec () {   
#      # xterm
#      print -Pn "\e]0;%n@%m: $1\a" 
#    }
#    precmd () {
#      print -Pn "\e]0;%n@%m: %~\a"  # xterm
#    }
#    ;;
#  screen*)
#    preexec () {
#      local CMD=${1[(wr)^(*=*|sudo|ssh|-*)]}
#      echo -ne "\ek$CMD\e\\"
#      print -Pn "\e]0;%n@%m: $1\a"  # xterm
#    }
#    precmd () {
#      echo -ne "\ekzsh\e\\"
#      print -Pn "\e]0;%n@%m: %~\a"  # xterm
#    }
#    ;;
#esac
