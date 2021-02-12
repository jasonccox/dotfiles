#!/bin/sh
#
# battery_monitor.sh - Check if battery is low and notify user, hibernate if
# needed. This script is meant to be run regularly via cron or systemd timers.

POLL_INTERVAL=60
WARN_THRESHOLD=10
CRITICAL_THRESHOLD=5
CRITICAL_TIMEOUT=60
DISCHARGE_STATUS=Discharging

setBatteryStatus() {
    local output="$(acpi -b)"

    # determine battery percent
    percent="${output#*, }"
    percent="${percent%\%, *}"

    # determine if battery is discharging
    status="${output#*: }"
    status="${status%%,*}"
}

doWarn() {
    # send a notification informing user that batter is low
    notify-send \
        --urgency=normal \
        "Low battery" \
        "You have less than 10% battery remaining. Time to plug in!"
}

doCritical() {
    # send a notification informing user that battery is critical
    notify-send \
        --urgency=critical \
        "Critically low battery" \
        "You have less than 5% battery remaining. Your laptop will automatically hibernate if not plugged in within $CRITICAL_TIMEOUT seconds"

    # give user a little time to plug in
    sleep $CRITICAL_TIMEOUT

    # check battery status again -- if it's still critical, hibernate
    setBatteryStatus
    if [ "$status" = "$DISCHARGE_STATUS" ] && [ "$percent" -le $CRITICAL_THRESHOLD ]; then
        logger "[battery_monitor.sh] Hibernating due to low battery ($percent%)"
        systemctl hibernate
    fi
}

done_warn=false
done_critical=false

while true; do
    setBatteryStatus

    if [ "$status" = "$DISCHARGE_STATUS" ]; then
        if [ "$percent" -le $CRITICAL_THRESHOLD ]; then
            $done_critical || doCritical
            done_critical=true
        elif [ "$percent" -le $WARN_THRESHOLD ]; then
            $done_warn || doWarn
            done_warn=true
            done_critical=false
        else
            done_critical=false
            done_warn=false
        fi
    else
        done_critical=false
        done_warn=false
    fi

    sleep $POLL_INTERVAL
done
