# 
# Bruno Bonfils, <asyd@debian-fr.org> 
# Written since summer 2001

# My functions (don't forget to modify fpath before call compinit !!)
fpath=($HOME/.zsh/functions $fpath)

# in order to have many completion function run comptinstall !

autoload -U zutil
autoload -U compinit
autoload -U complist

# Activation
compinit

# Global Resource files
for file in $HOME/.zsh/rc/*.rc; do
	source $file
done

local os host

# Set default umask to 027, can be override by host specific resource file
umask 027

# Hostnames resources files
host=${$(hostname)//.*/}
[ -f ".zsh/rc.host/${host}.zsh" ] && source ".zsh/rc.host/${host}.zsh"

# OS resources files
os=$(uname)
[ -f ".zsh/rc.os/${os}.zsh" ] && source ".zsh/rc.os/${os}.zsh"
