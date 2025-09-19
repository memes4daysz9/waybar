#!/bin/bash

# cpu usage percentage (strip decimals)
USAGE=$(mpstat 1 1 | awk '/Average/ {printf "%d", 100 - $NF}')
USAGEP="${USAGE}%"  # pretty print for user

THRESHOLD=50 #  cpu icon btw

if [[ $USAGE -gt $THRESHOLD ]]; then
    if [[ $USAGE -ge 90 ]]; then
        COLOR="#f38ba8"  # high load
    else
        COLOR="#a6e3a1"  # normal load
    fi
    printf "<span color='%s'>%s</span>" "$COLOR" "$USAGEP"
fi
