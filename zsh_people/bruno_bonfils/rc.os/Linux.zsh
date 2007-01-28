alias ls='ls --color'

# prompt, colors are defined in host resource file
autoload -U colors
colors

# Format
date_format="%H:%M"

date="%{$fg[$date_color]%}%D{$date_format}"
host="%{$fg[$host_color]%}%n%{$reset_color%}~%{$fg[$domain_color]%}%m"
cpath="%B%{$fg[$path_color]%}%/%b"
end="%{$reset_color%}"

# permit parameter expansion, command substitution and arithmetic expansion 
# in prompt
setopt prompt_subst

precmd () { 
	local buffer load
	load=(${$(< /proc/loadavg)})
	LOADAVG="$load[1] $load[2]"
	buffer=(${$(free)})
	MEM="$((100 * $buffer[16] / $buffer[8]))%%"
	if [[ $buffer[19] != 0 ]]; then
		MEM="$MEM $((100 * $buffer[20] / $buffer[19]))%%"
	fi
}

stats="%{$fg[$status_color]%}[\$LOADAVG - \$MEM]"

PS1="$date ($host$end) $cpath
$end%% "

RPS1="$stats%{$reset_color%}"

export PS1 RPS1

# function use to toggle RPS1 (which is very ugly for copy/paste)
function rmrps1 () {
	RPS1=""
}

function rps1 () {
	RPS1="$stats%{$reset_color%}"
}

# zstyle OS specific
eval `dircolors $HOME/.zsh/misc/dircolors.rc`

# Use LS_COLORS for color completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
