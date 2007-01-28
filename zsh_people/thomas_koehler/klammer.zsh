
### put all of this in .zshrc or try ". ~/zsh/klammer.zsh" in .zshrc

COLORX="[0;31;47m"
COLOR0="[0m"
COLOR1="[0;30;41m"
COLOR2="[0;30;42m"
COLOR3="[0;30;43m"
COLOR4="[0;30;44m"
COLOR5="[0;30;45m"
COLOR6="[0;30;46m"
COLOR7="[0;30;47m"
COLOR8="[0;34;41m"
COLOR9="[0;34;43m"
COLOR10="[0;37;44m"
COLOROFF="[0m"


highlight() {
   line=$*
   i=0
   j=0
   strlen=$#line
   while [ $i -le $strlen ] ; do
      i=$[i+1]
      x=$line[$i]
      case $x in
         (\{) j=$[j+1] ; eval print -n $"COLOR$j"$"x"$"COLOROFF" ;;
         (\})  eval print -n $"COLOR$j"$"x"$"COLOROFF" ; j=$[j-1] ;;
         (*) print -n $x ;;
      esac
   done
   print $COLOROFF
}

screenclearx () {
   print -n '7'
   print 
   local MYLINE="$LBUFFER$RBUFFER"
   highlight $MYLINE
   print -n '8'
#   print "${COLORX}Hit Enter to continue${COLOROFF}"
#   read -k
}
zle -N screenclearx
bindkey "^Xl" screenclearx
