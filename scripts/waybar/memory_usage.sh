#!/usr/bin/env bash

# Get memory usage information
mem_info=$(free -m | grep '^Mem:')
total=$(echo $mem_info | awk '{print $2}')
used=$(echo $mem_info | awk '{print $3}')
available=$(echo $mem_info | awk '{print $7}')

# Calculate percentage
percentage=$(( (used * 100) / total ))

# Format the output
if [ $total -gt 1024 ]; then
    # Display in GB if total memory is > 1GB
    used_gb=$(echo "scale=1; $used / 1024" | bc)
    total_gb=$(echo "scale=1; $total / 1024" | bc)
    display="${used_gb}G/${total_gb}G"
else
    # Display in MB
    display="${used}M/${total}M"
fi

# Output for waybar
echo "{\"text\":\"${percentage}%\", \"tooltip\":\"Memory Usage: $display ($percentage%)\"}"
