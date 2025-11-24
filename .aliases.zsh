#! /usr/bin/env zsh

alias :q="exit 0"
alias :Q=":q"
alias lg="lsgrep"
alias gping="gping --clear --color red,green,blue,yellow --vertical-margin 0 "$@""
alias please="sudo"
alias pls="please"
alias vim="nvim"
alias fd="fdfind"
alias fetch="autofetch"

function math () {
	julia -E "$*"
}
alias math="noglob math"

function autofetch() {
	if [ -d ".git" ]; then
		cd .
	else
		echo "\033[31m\033[1m[auto-fetch]\033[0m No Git repo detected. Nothing to fetch..."
		return 1
	fi
}

function git() {
	if [ "$#" -eq 0 ]; then
		git -c color.status=always status -sb |
		sed "1s/^##/$(printf '\033[32mS\033[31mU\033[0m')/" &&
		printf "\nM = modified\n? = unversioned\nA = added\nD = deleted\nR = renamed\n"

	else
		command git "$@"
	fi
}

function cd() { # Autofetch
	builtin cd "$@" || return
	if [ -d ".git" ]; then
		local COLOR='\033[35m' #purple
		echo "$COLOR\033[1m[auto-fetch]\033[0m Git repo detected. Starting fetch in background..."

		git fetch --quiet &! # &! disowns the process so it even gets finished, if you close the shell.
	fi
}

function gp() {
	# Check if at least one address is provided
	if [[ $# -lt 1 ]]; then
		echo "IPS to Ping (separated by space): "
		read gpingips
	fi
	echo "Total duration to display (seconds): "
	read duration
	echo "Ping interval (seconds): "
	read interval

	# Check if inputs are numbers
	if [[ ! $duration =~ ^[0-9]+$ ]]; then
		duration="30"
	fi

	if [[ ! $interval =~ ^[0-9]+$ ]]; then
		interval="0.2";
	fi

	if [[ $# -lt 1 ]]; then
		eval set -- $gpingips
	fi

	gping --buffer ${duration} --watch-interval ${interval} "$@"
	unset duration interval gpingips
}

fzf-find-widget () {
	setopt localoptions pipefail no_aliases 2> /dev/null
	local dir="$(
    FZF_DEFAULT_COMMAND=${FZF_ALT_C_COMMAND:-} \
    FZF_DEFAULT_OPTS=$(__fzf_defaults "--reverse --walker=dir,follow,hidden --scheme=path" "${FZF_ALT_C_OPTS-} +m") \
    FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd) < /dev/tty)" 
	if [[ -z "$dir" ]]; then
		zle redisplay
		return 0
	fi
	if [[ -f "$dir" ]]; then
		dir="$(dirname "$dir")"
	fi
	zle push-line
	BUFFER="cd -- ${(q)dir}" 
	zle accept-line
	local ret=$? 
	unset dir
	zle reset-prompt
	return $ret
}
zle -N fzf-find-widget # Register the widget
