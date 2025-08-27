#!/usr/bin/env bash

# Get CPU temperature
temp=$(sensors | grep -i 'core 0' | awk '{print $3}' | sed 's/+//g' | sed 's/°C//g' | cut -d'.' -f1)

# If sensors doesn't work, try alternative methods
if [ -z "$temp" ]; then
    # Try thermal zone
    if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
        temp=$(cat /sys/class/thermal/thermal_zone0/temp)
        temp=$((temp / 1000))
    else
        temp="N/A"
    fi
fi

# Determine status based on temperature
if [ "$temp" = "N/A" ]; then
    status="unknown"
    icon="󰴈"
    color="#555555"
elif [ "$temp" -gt 70 ]; then
    status="critical"
    icon=""
    color="#cc241d"
elif [ "$temp" -gt 60 ]; then
    status="warning"
    icon="󰴈"
    color="#e78a4e"
else
    status="normal"
    icon="󰴈"
    color="#d8a657"
fi

# Output JSON for waybar
echo "{\"text\":\"<span color='#202020' bgcolor='$color'> $icon </span> ${temp}°C\", \"class\":\"$status\", \"tooltip\":\"CPU Temperature: ${temp}°C\"}"
