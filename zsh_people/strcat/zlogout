# $Id: .zlogout,v 1.1 2004/06/10 10:01:29 dope Exp dope $
# 
# .zlogin is sourced in login shells.  It should contain commands that
# should be executed only in login shells.  It should be used to run a
# series of external commands (fortune, msgs, etc).

FORTUNE="/usr/games/fortune"
FORTUNE_OPTS="-s"
COWSAY="/usr/local/bin/cowsay"

# Only reset and clear if it's at the physical console.
if [ ! $DISPLAY ]; then
	if [ ! $SSH_CLIENT ]; then
		reset
	fi
fi

# Clear the screen so next person can't see anything from the session.
clear 

# Only for a normal user in the console, make the cow say a fortune *g*
if [ "$UID" != 0 ] && [ ! "${DISPLAY}" ]; then
	if [ -x ${COWSAY} ]; then
		if [ -x ${FORTUNE} ]; then
			${FORTUNE} ${FORTUNE_OPTS} | ${COWSAY} -nW80; echo
		fi
	elif [ -x ${FORTUNE} ]; then
		${FORTUNE} ${FORTUNE_OPTS}; echo
	fi
fi
