# MY UPTIME

  typeset -g POWERLEVEL9K_MY_UPTIME_FOREGROUND='#80cf65'
  typeset -g POWERLEVEL9K_MY_UPTIME_SHOW_SECONDS=true
  typeset -g POWERLEVEL9K_MY_UPTIME_VISUAL_IDENTIFIER_EXPANSION='󰜷'
  typeset -g POWERLEVEL9K_MY_UPTIME_PREFIX=''
# MY WIRED IP
  typeset -g POWERLEVEL9K_MY_WIRED_IP_FOREGROUND='#a050ff'
  typeset -g POWERLEVEL9K_MY_WIRED_IP_UNCONNECTED_FOREGROUND='#ffffff'
  typeset -g POWERLEVEL9K_MY_WIRED_IP_UNCONNECTED_BACKGROUND='#aa1100'
  typeset -g POWERLEVEL9K_MY_WIRED_IP_SHOWIFNAME=true
  typeset -g POWERLEVEL9K_MY_WIRED_IP_SHOWUNCONNECTED=true
  typeset -g POWERLEVEL9K_MY_WIRED_IP_SHOWNETSIZE=true
  typeset -g POWERLEVEL9K_MY_WIRED_IP_PREFIX='󰍸 '
  typeset -g POWERLEVEL9K_MY_WIRED_IP_UNCONNECTED_PREFIX='󰍸'
# MY WIFI IP
  typeset -g POWERLEVEL9K_MY_WIFI_IP_FOREGROUND='#a050ff'
  typeset -g POWERLEVEL9K_MY_WIFI_IP_UNCONNECTED_FOREGROUND='#ffffff'
  typeset -g POWERLEVEL9K_MY_WIFI_IP_UNCONNECTED_BACKGROUND='#aa1100'
  typeset -g POWERLEVEL9K_MY_WIFI_IP_SHOWIFNAME=true
  typeset -g POWERLEVEL9K_MY_WIFI_IP_SHOWUNCONNECTED=true
  typeset -g POWERLEVEL9K_MY_WIFI_IP_SHOWNETSIZE=true
  typeset -g POWERLEVEL9K_MY_WIFI_IP_PREFIX=' '
  typeset -g POWERLEVEL9K_MY_WIFI_IP_UNCONNECTED_PREFIX=''
# MY IF COUNT
  typeset -g POWERLEVEL9K_MY_IF_COUNT_FOREGROUND='#a050ff'
  typeset -g POWERLEVEL9K_MY_IF_COUNT_PREFIX='#'
  typeset -g POWERLEVEL9K_MY_IF_COUNT_MAXUSUAL=2
  typeset -g POWERLEVEL9K_MY_IF_COUNT_UNUSUAL_FOREGROUND='#cc2222'

#####################
# BEGIN OF SEGMENTS #
#####################

function prompt_my_wired_ip () {
	local interface=$( /bin/ip -4 addr show | /bin/grep -Eo '^[0-9]+: ([Ee]\w+)' | /bin/grep -Eo '[Ee]\w+' | /bin/head -n 1 )
	if [[ -n $interface ]]; then
		local ip=$( /bin/ip -4 addr show $interface | /bin/grep -Eo '[0-9]{1,3}(\.[0-9]{1,3}){3}' | head -n 1 )
		if [[ $POWERLEVEL9K_MY_WIRED_IP_SHOWNETSIZE == true ]]; then
			local netmask=$( /bin/ip -4 addr show $interface | /bin/grep -Eo '/[0-9]{1,2}' )
		fi
		if [[ $POWERLEVEL9K_MY_WIRED_IP_SHOWIFNAME == true ]]; then
			p10k segment -t "$interface: %B$ip%b$netmask"
		else
			p10k segment -t "%B$ip%b$netmask"
		fi
	else
		if [[ $POWERLEVEL9K_MY_WIRED_IP_SHOWUNCONNECTED == true ]]; then
			p10k segment -s UNCONNECTED -t "x"
		fi
	fi
}

function prompt_my_wifi_ip () {
	local interface=$( /bin/ip -4 addr show | /bin/grep -Eo '^[0-9]+: ([Ww]\w+)' | /bin/grep -Eo '[Ww]\w+' | /bin/head -n 1 )
	if [[ -n $interface ]]; then
		local ip=$( /bin/ip -4 addr show $interface | /bin/grep -Eo '[0-9]{1,3}(\.[0-9]{1,3}){3}' | head -n 1 )
		if [[ $POWERLEVEL9K_MY_WIFI_IP_SHOWNETSIZE == true ]]; then
			local netmask=$( /bin/ip -4 addr show $interface | /bin/grep -Eo '/[0-9]{1,2}' )
		fi
		if [[ $POWERLEVEL9K_MY_WIFI_IP_SHOWIFNAME == true ]]; then
			p10k segment -t "$interface: %B$ip%b$netmask"
		else
			p10k segment -t "%B$ip%b$netmask"
		fi
	else
		if [[ $POWERLEVEL9K_MY_WIFI_IP_SHOWUNCONNECTED == true ]]; then
			p10k segment -s UNCONNECTED -t "x"
		fi
	fi
}

function prompt_my_if_count () {
	local count=$( /bin/ip -4 addr show | /bin/grep -Eo '^[0-9]+: ([Ee]\w+|[Ww]\w+)' | /bin/wc -l )
	if [[ ( $count -le $POWERLEVEL9K_MY_IF_COUNT_MAXUSUAL ) && ( $count -gt 0 ) ]]; then
		p10k segment -t "%B$count%b"
	else
		p10k segment -s UNUSUAL -t "%B$count%b"
	fi
}
function prompt_my_uptime () {
	local uptime_seconds_in=$( /bin/cat /proc/uptime | /bin/awk '{print int($1)}' )
	local uptime_hours=$(( uptime_seconds_in / 3600 ))
	local uptime_minutes=$(( (uptime_seconds_in % 3600) / 60 ))

	if [[ $POWERLEVEL9K_MY_UPTIME_SHOW_SECONDS == true ]]; then
	local uptime_seconds=$(( uptime_seconds_in % 60 ))
		if (( uptime_minutes < 10 )); then
			if (( uptime_seconds < 10 )); then
				p10k segment -t "$uptime_hours:0$uptime_minutes:0$uptime_seconds"
			else
				p10k segment -t "$uptime_hours:0$uptime_minutes:$uptime_seconds"
			fi
		else
			if ((uptime_seconds < 10 )); then
				p10k segment -t "$uptime_hours:$uptime_minutes:0$uptime_seconds"
			else
				p10k segment -t "$uptime_hours:$uptime_minutes:$uptime_seconds"
			fi
		fi
	else
		if (( uptime_minutes < 10 )); then
			p10k segment -t "$uptime_hours:0$uptime_minutes"
		else
			p10k segment -t "$uptime_hours:$uptime_minutes"
		fi
	fi
}
