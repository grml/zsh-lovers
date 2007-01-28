# Filename:      .zshrc
# Purpose:       config file for zsh
# Authors:       grml-team (grml.org), (c) Michael Prokop <mika@grml.org>
# Bug-Reports:   see http://grml.org/bugs/
# License:       This file is licensed under the GPL v2.
# Latest change: Son Jun 05 21:06:19 CEST 2005 [mika]
################################################################################

# See /etc/zsh/zshrc for some general settings

## variables {{{

# set terminal property (used e.g. by msgid-chooser)
  export COLORTERM="yes"

# set default browser
  (( ${+BROWSER} )) || export BROWSER="w3m"
  (( ${+PAGER} ))   || export PAGER="less"
# }}}

## set options {{{

# Allow comments even in interactive shells i. e.
# $ uname # This command prints system informations
# zsh: bad pattern: #
# $ setopt interactivecomments
# $ uname # This command prints system informations
# Linux
#  setopt interactivecomments

# }}}

# {{{ global aliases
# These do not have to be at the beginning of the command line.
# Avoid typing cd ../../ for going two dirs down and so on
# Usage, e.g.: "$ cd ...' or just '$ ...' with 'setopt auto_cd'
  alias -g '...'='../..'
  alias -g '....'='../../..'
# Usage is "$ somecommand C (this pipes it into 'wc -l'):
  alias -g BG='& exit'
  alias -g C='|wc -l'
  alias -g G='|grep'
  alias -g H='|head'
  alias -g Hl=' --help |& less -r'
  alias -g K='|keep'
  alias -g L='|less'
  alias -g M='|most'
  alias -g N='&>/dev/null'
  alias -g R='| tr A-z N-za-m'
  alias -g SL='| sort | less'
  alias -g S='| sort'
  alias -g T='|tail'
  alias -g V='| vim -'
# }}}

## aliases {{{

# general
  alias da='du -sch'
  alias j='jobs -l'
#  alias u='translate -i'          # translate

# compile stuff
  alias CO="./configure"
  alias CH="./configure --help"

# http://conkeror.mozdev.org/
  alias conkeror='firefox -chrome chrome://conkeror/content'

# arch/tla stuff
  alias ldiff='tla what-changed --diffs | less'
  alias tbp='tla-buildpackage'
  alias mirror='tla archive-mirror'
  alias commit='tla commit'
  alias merge='tla star-merge'

# listing stuff
  alias dir="ls -lSrah"
  alias lad='ls -d .*(/)'                # only show dot-directories
  alias lsa='ls -a .*(.)'                # only show dot-files
  alias lss='ls -l *(s,S,t)'             # only files with setgid/setuid/sticky flag
  alias lsl='ls -l *(@[1,10])'           # only symlinks
  alias lsx='ls -l *(*[1,10])'           # only executables
  alias lsw='ls -ld *(R,W,X.^ND/)'       # world-{readable,writable,executable} files
  alias lsbig="ls -flh *(.OL[1,10])"     # display the biggest files
  alias lsd='ls -d *(/)'                 # only show directories
  alias lse='ls -d *(/^F)'               # only show empty directories
  alias lsnew="ls -rl *(D.om[1,10])"     # display the newest files
  alias lsold="ls -rtlh *(D.om[1,10])"   # display the oldest files
  alias lssmall="ls -Srl *(.oL[1,10])"   # display the smallest files

# chmod   
  alias rw-='chmod 600'
  alias rwx='chmod 700'
  alias r--='chmod 644'
  alias r-x='chmod 755'

# some useful aliases
  alias md='mkdir -p'

# console stuff
  alias cmplayer='mplayer -vo fbdev'
  alias fbmplayer='mplayer -vo fbdev'
  alias fblinks='links2 -driver fb'

# use colors when browsing man pages (if not using pinfo or PAGER=most)
  [ -d ~/.terminfo/ ] && alias man='TERMINFO=~/.terminfo/ LESS=C TERM=mostlike PAGER=less man'

# }}}

## useful functions {{{

# functions without detailed explanation:
  agoogle() { $BROWSER "http://groups.google.com/groups?as_uauthors=$*" ; }
  bk()      { cp -b ${1} ${1}_`date --iso-8601=m` }
  cdiff()   { diff -crd "$*" | egrep -v "^Only in |^Binary files " }
  cl()      { cd $1 && ls -a }        # cd && ls
  cvsa()    { cvs add $* && cvs com -m 'initial checkin' $* }
  cvsd ()   { cvs diff -N $* |& $PAGER }
  cvsl ()   { cvs log $* |& $PAGER }
  cvsq ()   { cvs -nq update }
  cvsr ()   { rcs2log $* | $PAGER }
  cvss ()   { cvs status -v $* }
  debbug () { $BROWSER "http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=$*" }
  disassemble(){ gcc -pipe -S -o - -O -g $* | as -aldh -o /dev/null }
  dwicti()  { $BROWSER http://de.wiktionary.org/wiki/${(C)1// /_} } 
  ewicti()  { $BROWSER http://en.wiktionary.org/wiki/${(C)1// /_} } 
  ggogle()  { $BROWSER "http://groups.google.com/groups?q=$*" }
  google()  { $BROWSER "http://www.google.com/search?&num=100&q=$*" }
  leo()     { $BROWSER "http://dict.leo.org/?search=$*" }
  mdiff()   { diff -udrP "$1" "$2" > diff.`date "+%Y-%m-%d"`."$1" }
  memusage(){ ps aux | awk '{if (NR > 1) print $5; if (NR > 2) print "+"} END { print "p" }' | dc }
  mggogle() { $BROWSER "http://groups.google.com/groups?selm=$*" }
  shtar()   { gunzip -c $1 | tar -tf - -- | $PAGER }
  shtgz()   { tar -ztf $1 | $PAGER }
  shzip()   { unzip -l $1 | $PAGER }
  sig()     { agrep -d '^-- $' "$*" ~/.Signature }
  udiff()   { diff -urd $* | egrep -v "^Only in |^Binary files " }
  wikide()  { $BROWSER http://de.wikipedia.org/wiki/"$*" }
  wikien()  { $BROWSER http://en.wikipedia.org/wiki/"$*" }

# debian upgrade
  upgrade () {
    if [ -z $1 ] ; then
        sudo apt-get update
        sudo apt-get -u upgrade
    else
        ssh $1 sudo apt-get update
        # ask before the upgrade
        local dummy
        ssh $1 sudo apt-get --no-act upgrade
        echo -n "Process the upgrade ?"
        read -q dummy
        if [[ $dummy == "y" ]] ; then
            ssh $1 sudo apt-get -u upgrade --yes
        fi
    fi
  }

# make screenshot of current desktop (use 'import' from ImageMagic)
  sshot() {
        [[ ! -d ~/shots  ]] && mkdir ~/shots
        #cd ~/shots ; sleep 5 ; import -window root -depth 8 -quality 80 `date "+%Y-%m-%d--%H:%M:%S"`.png
        cd ~/shots ; sleep 5; import -window root shot_`date --iso-8601=m`.jpg
  }

# create pdf file from source code
  makereadable() {
     output=$1
     shift
     a2ps --medium A4dj -E -o $output $*
     ps2pdf $output
  }

# zsh with perl-regex - use it e.g. via:
# regcheck '\s\d\.\d{3}\.\d{3} Euro' ' 1.000.000 Euro'
  regcheck() {
    zmodload -i zsh/pcre
    pcre_compile $1 && \
    pcre_match $2 && echo "regex matches" || echo "regex does not match"
  }
# list files which have been modified within the last x days
  new() { print -l *(m-$1) }

# grep the history
  greph () { history 0 | grep $1 }
  alias grepc='grep --color=auto'
  alias GREP='grep -i --color=auto'

# one blank line between each line
  man2() { PAGER='sed G | less' /usr/bin/man $* ; }

# provide useful information on globbing
  H-Glob() {
  echo -e "
      /      directories
      .      plain files
      @      symbolic links
      =      sockets
      p      named pipes (FIFOs)
      *      executable plain files (0100)
      %      device files (character or block special)
      %b     block special files
      %c     character special files
      r      owner-readable files (0400)
      w      owner-writable files (0200)
      x      owner-executable files (0100)
      A      group-readable files (0040)
      I      group-writable files (0020)
      E      group-executable files (0010)
      R      world-readable files (0004)
      W      world-writable files (0002)
      X      world-executable files (0001)
      s      setuid files (04000)
      S      setgid files (02000)
      t      files with the sticky bit (01000)
   print *(m-1)          # Dateien, die vor bis zu einem Tag modifiziert wurden.
   print *(a1)           # Dateien, auf die vor einem Tag zugegriffen wurde.
   print *(@)            # Nur Links
   print *(Lk+50)        # Dateien die ueber 50 Kilobytes grosz sind
   print *(Lk-50)        # Dateien die kleiner als 50 Kilobytes sind
   print **/*.c          # Alle *.c - Dateien unterhalb von \$PWD
   print **/*.c~file.c   # Alle *.c - Dateien, aber nicht 'file.c'
   print (foo|bar).*     # Alle Dateien mit 'foo' und / oder 'bar' am Anfang
   print *~*.*           # Nur Dateien ohne '.' in Namen
   chmod 644 *(.^x)      # make all non-executable files publically readable
   print -l *(.c|.h)     # Nur Dateien mit dem Suffix '.c' und / oder '.h'
   print **/*(g:users:)  # Alle Dateien/Verzeichnisse der Gruppe >users<
   echo /proc/*/cwd(:h:t:s/self//) # Analog zu >ps ax | awk '{print $1}'<"
  }

  lcheck() {
   nm -go /usr/lib/lib*.a 2>/dev/null | grep ":[[:xdigit:]]\{8\} . .*$1"":[[:xdigit:]]\{8\} . .*$1"
  }

# clean up directory
  purge() {
        FILES=(*~(N) .*~(N) \#*\#(N) *.o(N) a.out(N) *.core(N) *.cmo(N) *.cmi(N) .*.swp(N))
        NBFILES=${#FILES}
        if [[ $NBFILES > 0 ]]; then
                print $FILES
                local ans
                echo -n "Remove this files? [y/n] "
                read -q ans
                if [[ $ans == "y" ]]
                then
                        rm ${FILES}
                        echo ">> $PWD purged, $NBFILES files removed"
                else
                        echo "Ok. .. than not.."
                fi
        fi
   }

# Translate DE<=>EN
# 'translate' looks up fot a word in a file with language-to-language
# translations (field separator should be " : "). A typical wordlist looks
# like at follows:
#  | english-word : german-transmission
# It's also only possible to translate english to german but not reciprocal.
# Use the following oneliner to turn back the sort order:
#  $ awk -F ':' '{ print $2" : "$1" "$3 }' \
#    /usr/local/lib/words/en-de.ISO-8859-1.vok > ~/.translate/de-en.ISO-8859-1.vok
  trans() {
        case "$1" in
                -[dD]*) translate -l de-en $2
                ;;
                -[eE]*) translate -l en-de $2
                ;;
                *)
                echo "Usage: $0 { -D | -E }"
                echo "         -D == German to English"
                echo "         -E == English to German"
        esac
  }

# Some quick Perl-hacks aka /useful/ oneliner
#  bew() { perl -le 'print unpack "B*","'$1'"' }
#  web() { perl -le 'print pack "B*","'$1'"' }
#  hew() { perl -le 'print unpack "H*","'$1'"' }
#  weh() { perl -le 'print pack "H*","'$1'"' }
#  pversion()    { perl -M$1 -le "print $1->VERSION" } # i. e."pversion LWP -> 5.79"
#  getlinks ()   { perl -ne 'while ( m/"((www|ftp|http):\/\/.*?)"/gc ) { print $1, "\n"; }' $* }
#  gethrefs ()   { perl -ne 'while ( m/href="([^"]*)"/gc ) { print $1, "\n"; }' $* }
#  getanames ()  { perl -ne 'while ( m/a name="([^"]*)"/gc ) { print $1, "\n"; }' $* }
#  getforms ()   { perl -ne 'while ( m:(\</?(input|form|select|option).*?\>):gic ) { print $1, "\n"; }' $* }
#  getstrings () { perl -ne 'while ( m/"(.*?)"/gc ) { print $1, "\n"; }' $*}
#  getanchors () { perl -ne 'while ( m/«([^«»\n]+)»/gc ) { print $1, "\n"; }' $* }
#  showINC ()    { perl -e 'for (@INC) { printf "%d %s\n", $i++, $_ }' }
#  vimpm ()      { vim `perldoc -l $1 | sed -e 's/pod$/pm/'` }
#  vimhelp ()    { vim -c "help $1" -c on -c "au! VimEnter *" }

# plap foo -- list all occurrences of program in the current PATH
  plap() {
        if [[ $# = 0 ]]
        then
                echo "Usage:    $0 program"
                echo "Example:  $0 zsh"
                echo "Lists all occurrences of program in the current PATH."
        else
                ls -l ${^path}/*$1*(*N)
        fi
  }

# Found in the mailinglistarchive from Zsh (IIRC ~1996)
  selhist() {
        emulate -L zsh
        local TAB=$'\t';
        (( $# < 1 )) && {
                echo "Usage: $0 command"
                return 1
        };
        cmd=(${(f)"$(grep -w $1 $HISTFILE | sort | uniq | pr -tn)"})
        print -l $cmd | less -F
        echo -n "enter number of desired command [1 - $(( ${#cmd[@]} - 1 ))]: "
        local answer
        read answer
        print -z "${cmd[$answer]#*$TAB}"
  }

# mkdir && cd
  mcd() { mkdir -p "$@"; cd "$@" }  # mkdir && cd

# cd && ls
  cl() { cd $1 && ls -a }

# Use vim to convert plaintext to HTML
  2html() { vim -u NONE -n -c ':syntax on' -c ':so $VIMRUNTIME/syntax/2html.vim' -c ':wqa' $1 > /dev/null 2> /dev/null }

# Usage: simple-extract <file>
# Description: extracts archived files (maybe)
  simple-extract () {
        if [[ -f $1 ]]
        then
                case $1 in
                        *.tar.bz2)  bzip2 -v -d $1      ;;
                        *.tar.gz)   tar -xvzf $1        ;;
                        *.rar)      unrar $1            ;;
                        *.deb)      ar -x $1            ;;
                        *.bz2)      bzip2 -d $1         ;;
                        *.lzh)      lha x $1            ;;
                        *.gz)       gunzip -d $1        ;;
                        *.tar)      tar -xvf $1         ;;
                        *.tgz)      gunzip -d $1        ;;
                        *.tbz2)     tar -jxvf $1        ;;
                        *.zip)      unzip $1            ;;
                        *.Z)        uncompress $1       ;;
                        *)          echo "'$1' Error. Please go away" ;;
                esac
        else
                echo "'$1' is not a valid file"
        fi
  }

# Usage: smartcompress <file> (<type>)
# Description: compresses files or a directory.  Defaults to tar.gz
  smartcompress() {
        if [ $2 ]; then
                case $2 in
                        tgz | tar.gz)   tar -zcvf$1.$2 $1 ;;
                        tbz2 | tar.bz2) tar -jcvf$1.$2 $1 ;;
                        tar.Z)          tar -Zcvf$1.$2 $1 ;;
                        tar)            tar -cvf$1.$2  $1 ;;
                        gz | gzip)      gzip           $1 ;;
                        bz2 | bzip2)    bzip2          $1 ;;
                        *)
                        echo "Error: $2 is not a valid compression type"
                        ;;
                esac
        else
                smartcompress $1 tar.gz
        fi
  }

# Usage: show-archive <archive>
# Description: view archive without unpack
  show-archive() {
        if [[ -f $1 ]]
        then
                case $1 in
                        *.tar.gz)      gunzip -c $1 | tar -tf - -- ;;
                        *.tar)         tar -tf $1 ;;
                        *.tgz)         tar -ztf $1 ;;
                        *.zip)         unzip -l $1 ;;
                        *.bz2)         bzless $1 ;;
                        *)             echo "'$1' Error. Please go away" ;;
                esac
        else
                echo "'$1' is not a valid archive"
        fi
  }

  folsym() {
    if [[ -e $1 || -h $1 ]]; then
        file=$1
    else
        file=`which $1`
    fi
    if [[ -e $file || -L $file ]]; then
        if [[ -L $file ]]; then
            echo `ls -ld $file | perl -ane 'print $F[7]'` '->'
            folsym `perl -le '$file = $ARGV[0];
                              $dest = readlink $file;
                              if ($dest !~ m{^/}) {
                                  $file =~ s{(/?)[^/]*$}{$1$dest};
                              } else {
                                  $file = $dest;
                              }
                              $file =~ s{/{2,}}{/}g;
                              while ($file =~ s{[^/]+/\.\./}{}) {
                                  ;
                              }
                              $file =~ s{^(/\.\.)+}{};
                              print $file' $file`
        else
            ls -d $file
        fi
    else
        echo $file
    fi
  }

# Use 'view' to read manpages, if u want colors, regex - search, ...
# like vi(m).
# It's shameless stolen from <http://www.vim.org/tips/tip.php?tip_id=167>
  vman() { man $* | col -b | view -c 'set ft=man nomod nolist' - }

# search for various types or README file in dir and display them in $PAGER
# function readme() { $PAGER -- (#ia3)readme* }
  readme() {
        local files
        files=(./(#i)*(read*me|lue*m(in|)ut)*(ND))
        if (($#files))
        then $PAGER $files
        else
                print 'No README files.'
        fi
  }

# find all suid files in $PATH
  suidfind() { ls -latg $path | grep '^...s' }

# See above but this is /better/ ... anywise ..
#  Note: Add $USER and 'find' with "NOPASSWD" in your /etc/sudoers or run it
#        as root (UID == 0)
  findsuid() {
    if [ UID != 0 ] ; then
      print 'Not running as root. Trying to run via sudo...'
      RUNASROOT=sudo
    fi
        print 'Output will be written to ~/suid_* ...'
        $RUNASROOT find / -type f \( -perm -4000 -o -perm -2000 \) -ls > ~/suid_suidfiles.`date "+%Y-%m-%d"`.out 2>&1
        $RUNASROOT find / -type d \( -perm -4000 -o -perm -2000 \) -ls > ~/suid_suiddirs.`date "+%Y-%m-%d"`.out 2>&1
        $RUNASROOT find / -type f \( -perm -2 -o -perm -20 \) -ls > ~/suid_writefiles.`date "+%Y-%m-%d"`.out 2>&1
        $RUNASROOT find / -type d \( -perm -2 -o -perm -20 \) -ls > ~/suid_writedirs.`date "+%Y-%m-%d"`.out 2>&1
        print 'Finished'
  }

# Reload functions.
  refunc() {
        for func in $argv
        do
                unfunction $func
                autoload $func
        done
  }

# a small check to see which DIR is located on which server/partition.
# stolen and modified from Sven's zshrc.forall
  dirspace() {
        for dir in $path;
        do
                (cd $dir; echo "-<$dir>"; du -shx .; echo);
        done
  }

# $ show_print `cat /etc/passwd`
  slow_print() {
        for argument in "${@}"
        do
                for ((i = 1; i <= ${#1} ;i++)) {
                        print -n "${argument[i]}"
                        sleep 0.08
                }
                print -n " "
        done
        print ""
  }

  status() {
        print ""
        print "Date..: "$(date "+%Y-%m-%d %H:%M:%S")""
        print "Shell.: Zsh $ZSH_VERSION (PID = $$, $SHLVL nests)"
        print "Term..: $TTY ($TERM), $BAUD bauds, $COLUMNS x $LINES cars"
        print "Login.: $LOGNAME (UID = $EUID) on $HOST"
        print "System: $(cat /etc/[A-Za-z]*[_-][rv]e[lr]*)"
        print "Uptime:$(uptime)"
        print ""
  }

  audiorip() {
        mkdir -p ~/ripps
        cd ~/ripps
        cdrdao read-cd --device $DEVICE --driver generic-mmc audiocd.toc
        cdrdao read-cddb --device $DEVICE --driver generic-mmc audiocd.toc
        echo " * Would you like to burn the cd now? (yes/no)"
        read input
        if
                [ "$input" = "yes" ]; then
                echo " ! Burning Audio CD"
                audioburn
                echo " * done."
        else
                echo " ! Invalid response."
        fi
  }

  audioburn() {
        cd ~/ripps
        cdrdao write --device $DEVICE --driver generic-mmc audiocd.toc
        echo " * Should I remove the temporary files? (yes/no)"
        read input
        if [ "$input" = "yes" ]; then
                echo " ! Removing Temporary Files."
                cd ~
                rm -rf ~/ripps
                echo " * done."
        else
                echo " ! Invalid response."
        fi
  }

  mkaudiocd() {
        cd ~/ripps
        for i in *.[Mm][Pp]3; do mv "$i" `echo $i | tr '[A-Z]' '[a-z]'`; done
        for i in *.mp3; do mv "$i" `echo $i | tr ' ' '_'`; done
        for i in *.mp3; do mpg123 -w `basename $i .mp3`.wav $i; done
        normalize -m *.wav
        for i in *.wav; do sox $i.wav -r 44100 $i.wav resample; done
  }

  mkiso() {
        echo " * Volume name "
        read volume
        echo " * ISO Name (ie. tmp.iso)"
        read iso
        echo " * Directory or File"
        read files
        mkisofs -o ~/$iso -A $volume -allow-multidot -J -R -iso-level 3 -V $volume -R $files
  }

# generate thumbnails ;)
  genthumbs () {
    rm -rf thumb-* index.html
    echo "
<html>
  <head>
    <title>Images</title>
  </head>
  <body>" > index.html
    for f in *.(gif|jpeg|jpg|png)
    do
        convert -size 100x200 "$f" -resize 100x200 thumb-"$f"
        echo "    <a href=\"$f\"><img src=\"thumb-$f\"></a>" >> index.html
    done
    echo "
  </body>
</html>" >> index.html
  }

# unset all limits (see zshbuiltins(1) /ulimit for details)
  allulimit() {
    ulimit -c unlimited
    ulimit -d unlimited
    ulimit -f unlimited
    ulimit -l unlimited
    ulimit -n unlimited
    ulimit -s unlimited
    ulimit -t unlimited
  }

# ogg2mp3 with bitrate of 192
ogg2mp3_192() {
  oggdec -o - ${1} | lame -b 192 - ${1:r}.mp3
}

# }}}

# some useful commands often hard to remember - let's grep for them {{{

# enable jackd:
#  /usr/bin/jackd -dalsa -dhw:0 -r48000 -p1024 -n2
# now play audio file:
#  alsaplayer -o jack foobar.mp3

# send files via netcat
# on sending side:
#  send() {j=$*; tar cpz ${j/%${!#}/}|nc -w 1 ${!#} 51330;}
#  send dir* $HOST                                                                                               # alias receive='nc -vlp 51330 | tar xzvp'

# debian stuff:
# dh_make -e foo@localhost -f $1
# dpkg-buildpackage -rfakeroot
# lintian *.deb
# dpkg-scanpackages ./ /dev/null | gzip > Packages.gz
# dpkg-scansources . | gzip > Sources.gz
# grep-dctrl --field Maintainer $* /var/lib/apt/lists/*

# other stuff:
# convert -geometry 200x200 -interlace LINE -verbose
# ldapsearch -x -b "OU=Bedienstete,O=tug" -h ldap.tugraz.at sn=$1
# ps -ao user,pcpu,start,command
# gpg --keyserver blackhole.pca.dfn.de --recv-keys
# xterm -bg black -fg yellow -fn -misc-fixed-medium-r-normal--14-140-75-75-c-90-iso8859-15 -ah
# nc -vz $1 1-1024   # portscan via netcat
# wget --mirror --no-parent --convert-links
# pal -d `date +%d`
# autoload -U tetris; zle -N tetris; bindkey '...' ; echo "press ... for playing tennis"
# }}}
## END OF FILE #################################################################
# vim:foldmethod=marker
