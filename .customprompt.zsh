function prompt_my_uptime() {
	local uptime_seconds_in=$( cat /proc/uptime | awk '{print int($1)}' )
	local uptime_hours=$(( uptime_seconds_in / 3600 ))
	local uptime_minutes=$(( (uptime_seconds_in % 3600) / 60 ))
	local uptime_seconds=$(( uptime_seconds_in % 60 ))

	if [[ $POWERLEVEL9K_MY_UPTIME_SECONDS == true ]]; then
		if (( uptime_minutes < 10 )); then
			if (( uptime_seconds < 10 )); then
				p10k segment -t "uptime: $uptime_hours:0$uptime_minutes:0$uptime_seconds"
			else
				p10k segment -t "uptime: $uptime_hours:0$uptime_minutes:$uptime_seconds"
			fi
		else
			if ((uptime_seconds < 10 )); then
				p10k segment -t "uptime: $uptime_hours:$uptime_minutes:0$uptime_seconds"
			else
				p10k segment -t "uptime: $uptime_hours:$uptime_minutes:$uptime_seconds"
			fi
		fi
	else
		if (( uptime_minutes < 10 )); then
			p10k segment -t "uptime: $uptime_hours:0$uptime_minutes"
		else
			p10k segment -t "uptime: $uptime_hours:$uptime_minutes"
		fi
	fi
}
