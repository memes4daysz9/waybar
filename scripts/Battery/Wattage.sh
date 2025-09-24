#!/bin/bash

CAP=$(cat /sys/class/power_supply/BAT1/capacity)
watts=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | awk -F: '/energy-rate/ {gsub("W", "", $2); print $2}' | xargs)
wattT=$(printf "%.0f" "$watts")


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


printf "<span color='%s'>%s %sw</span>" "$COLOR" "$wattT"
