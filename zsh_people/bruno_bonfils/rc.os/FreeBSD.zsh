# Alias
 
alias date-rfc822="date '+%a, %d %b %Y %X %z'"

# Prompt 

autoload -U colors
colors

# Format
date_format="%H:%M"

date="%{$fg[$date_color]%}%D{$date_format}"
host="%{$fg[$host_color]%}%n%{$reset_color%}~%{$fg[$domain_color]%}%m"
cpath="%{$fg[$path_color]%}%/%b"
end="%{$reset_color%}"

PS1="$date ($host$end) $cpath
$end%% "

# Check for GNULS
if [ -x $(which gnuls) ] ; then
	eval `dircolors $HOME/.zsh/misc/dircolors.rc`
	alias ls='gnuls --color'
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
