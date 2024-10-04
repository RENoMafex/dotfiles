function prompt_my_uptime() {
	local uptime_seconds=$(cat /proc/uptime | awk '{print int($1)}')
	local uptime_hours=$((uptime_seconds / 3600))
	local uptime_minutes=$(( (uptime_seconds % 3600) / 60 ))
	
	if (( uptime_minutes < 10 )); then
		p10k segment -f green -t "uptime: $uptime_hours:0$uptime_minutes"
	else
		p10k segment -f green -t "uptime: $uptime_hours:$uptime_minutes"
	fi
}
