#!/bin/sh
#
# status_command.sh - Script to be used to as `status_command` in swaybar.
#
# Requirements
# - acpi
# - pulsemixer

printBatteryStatus() {
    # get battery status info
    local status="$(acpi -b)"

    # parse percent
    local percent="${status#*, }"
    percent="${percent%, *}"

    # determine if the battery is charging
    local charging="$(echo $status | grep -q ': Charging' && echo -n '+')"

    # print the results
    echo -n "B $percent$charging"
}

printVolume() {
    local out=""

    # determine if audio is muted
    if [ "$(pulsemixer --get-mute)" = 1 ]; then
        out="mute"
    else
        # get volume 
        local volume="$(pulsemixer --get-volume)"

        # just take the first volume value, assuming left and right are equal
        out="${volume%% *}%"
    fi

    echo -n "V $out"
}

printDateTime() {
    date +'%a, %b %-d  %-H:%M'
}

while true; do
    echo " $(printBatteryStatus) | $(printVolume) | $(printDateTime) "
    sleep 1
done
