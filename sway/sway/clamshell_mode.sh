#!/bin/sh
#
# clamshell_mode.sh - Ensure that the laptop display stays off when it's closed,
# even after reloading sway.
#
# Source: https://github.com/swaywm/sway/wiki#clamshell-mode

laptop="$1"

if cat /proc/acpi/button/lid/LID/state | grep -q open; then
    swaymsg output "$laptop" enable
else
    swaymsg output "$laptop" disable
fi
