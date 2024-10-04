function prompt_my_uptime() {
	local uptime_seconds=$(cat /proc/uptime | awk '{print int($1)}')
	local uptime_hours=$((uptime_seconds / 3600))
	local uptime_minutes=$(( (uptime_seconds % 3600) / 60 ))

	p10k segment -f green -t "uptime: $uptime_hours:$uptime_minutes"
}
