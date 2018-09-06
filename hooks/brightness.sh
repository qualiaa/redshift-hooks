#!/usr/bin/env sh

set -eu

exec >> ~/.redshift_log 2>&1

# path to github.com/qualiaa/acpi-brightness script
readonly brightness=$HOME/usr/bin/brightness 
readonly fade_time=$(( 60*60 ))

function brightness() {
    local seconds=${1:-0}
    local cond=${2:-}
    "$brightness" -t $seconds $cond $percent
}

if [[ "$1" == period-changed ]]; then
    case "$3" in
        daytime)
            percent=100
            case $2 in
                transition)
                    brightness $fade_time --inc ;;
                none)
                    brightness
            esac ;;
        transition)
            percent=70
            case $2 in
                daytme)
                    brightness $fade_time --dec ;;
                night)
                    brightness $fade_time --inc ;;
                none)
                    brightness
            esac ;;
        night)
            percent=40
            case $2 in
                transition)
                    brightness $fade_time --dec ;;
                none)
                    brightness
            esac
    esac
fi
