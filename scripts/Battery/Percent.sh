#!/bin/bash

BAT=$(ls /sys/class/power_supply/ | grep -i BAT | head -n1)
CAP=$(cat /sys/class/power_supply/$BAT/capacity)
STATE=$(cat /sys/class/power_supply/$BAT/status)
watts=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | awk -F: '/energy-rate/ {gsub("W", "", $2); print $2}' | xargs)


if [ -f /sys/class/power_supply/$BAT/energy_now ]; then
    NOW=$(cat /sys/class/power_supply/$BAT/energy_now)
    FULL=$(cat /sys/class/power_supply/$BAT/energy_full)
    POWER=$(cat /sys/class/power_supply/$BAT/power_now)
else
    NOW=$(cat /sys/class/power_supply/$BAT/charge_now)
    FULL=$(cat /sys/class/power_supply/$BAT/charge_full)
    POWER=$(cat /sys/class/power_supply/$BAT/current_now)
fi

if [ "$STATE" = "Charging" ] && [ "$POWER" -gt 0 ]; then
    ICON="↑"
elif [ "$STATE" = "Discharging" ] && [ "$POWER" -gt 0 ]; then
    ICON="↓"
else
    ICON=""
fi



# choose color based on percentage
if [ $CAP -ge 75 ]; then
    COLOR="#a6e3a1"
elif [ $CAP -ge 50 ]; then
    COLOR="#f9e2af"
elif [ $CAP -ge 25 ]; then
    COLOR="#f38ba8"
else
    COLOR="#f38ba8"
fi


printf "<span color='%s'>%s %s%%</span>" "$COLOR" "$ICON" "$CAP"

