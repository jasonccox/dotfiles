#!/bin/sh
#
# status_command.sh - Script to be used to as `status_command` in swaybar.
#
# Requirements
# - acpi
# - pulsemixer

printBatteryStatus() {
    # parse percent from battery status info
    local status="$(acpi -b)"
    local percent="${status#*, }"
    percent="${percent%, *}"

    # determine if the battery is charging
    local charging="$(acpi -a | grep -q 'on-line' && echo -n '+')"

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
