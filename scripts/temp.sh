#!/bin/bash

#temp

# Get CPU temperature (in °C, strip + and decimals)
TEMP=$(sensors | awk '/^Package id 0:/ {gsub("\\+",""); printf("%d",$4)}')

THRESHOLD=50

# 🌡️ cpu temp icon btw
if [[ $TEMP -gt $THRESHOLD ]]; then
    if [[ $TEMP -ge 90 ]]; then
        COLOR="#f38ba8"  # hot
    else
        COLOR="#a6e3a1"  # normal
    fi
    printf "<span color='%s'>%s</span>" "$COLOR" "$TEMP"
fi
