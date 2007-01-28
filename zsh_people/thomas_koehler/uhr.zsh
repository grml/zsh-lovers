# a watch for the prompt
# I have a multiline prompt, so beware!
# you may need to adjust the parameters
trap CRON ALRM
TMOUT=1
CRON() {
   STRING=$(date)
   # to right adjust the date: How many columns does our terminal
   # have? Reduce by the length of $STRING+5
   COL=$[COLUMNS-5]
   COL=$[COL-$#STRING]
   # Store the current cursor position; jump up two lines; jump to
   # columns $COL
   echo -n "7[2;A[$COL;G"
   echo -n ""
   # echo the date
   echo -n "[0;37;44m-- $STRING --[0m"
   # restore cursor position
   echo -n "8"
}

