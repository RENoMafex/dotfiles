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

fzf-history-widget () {
	local selected
	setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases noglob nobash_rematch 2> /dev/null
	if zmodload -F zsh/parameter p:{commands,history} 2> /dev/null && (( ${+commands[perl]} ))
	then
		selected="$(printf '%s\t%s\000' "${(kv)history[@]}" |
      perl -0 -ne 'if (!$seen{(/^\s*[0-9]+\**\t(.*)/s, $1)}++) { s/\n/\n\t/g; print; }' |
      FZF_DEFAULT_OPTS=$(__fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort,alt-r:toggle-raw --wrap-sign '\t↳ ' --highlight-line ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m --read0") \
      FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd))" 
	else
		selected="$(fc -rl 1 | __fzf_exec_awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
      FZF_DEFAULT_OPTS=$(__fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort,alt-r:toggle-raw --wrap-sign '\t↳ ' --highlight-line ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m") \
      FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd))" 
	fi
	local ret=$? 
	if [ -n "$selected" ]
	then
		if [[ $(__fzf_exec_awk '{print $1; exit}' <<< "$selected") =~ ^[1-9][0-9]* ]]
		then
			zle vi-fetch-history -n $MATCH
		else
			LBUFFER="$selected" 
		fi
	fi
	zle reset-prompt
	return $ret
}
zle -N fzf-history-widget # Register the widget

__fzfcmd () {
	[ -n "${TMUX_PANE-}" ] && {
		[ "${FZF_TMUX:-0}" != 0 ] || [ -n "${FZF_TMUX_OPTS-}" ]
	} && echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}
__fzf_defaults () {
	printf '%s\n' "--height ${FZF_TMUX_HEIGHT:-40%} --min-height 20+ --bind=ctrl-z:ignore $1"
	command cat "${FZF_DEFAULT_OPTS_FILE-}" 2> /dev/null
	printf '%s\n' "${FZF_DEFAULT_OPTS-} $2"
}
__fzf_exec_awk () {
	if [[ -z ${__fzf_awk-} ]]
	then
		__fzf_awk=awk 
		if [[ $OSTYPE == solaris* && -x /usr/xpg4/bin/awk ]]
		then
			__fzf_awk=/usr/xpg4/bin/awk 
		elif command -v mawk > /dev/null 2>&1
		then
			local n x y z d
			IFS=' .' read -r n x y z d <<< $(command mawk -W version 2> /dev/null)
			[[ $n == mawk ]] && (((x * 1000 + y) * 1000 + z >= 1003004)) 2> /dev/null && ((d >= 20230302)) 2> /dev/null && __fzf_awk=mawk 
		fi
	fi
	LC_ALL=C exec "$__fzf_awk" "$@"
}
