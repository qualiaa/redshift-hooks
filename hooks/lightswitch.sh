#!/bin/sh

set -eu

exec >> ~/.redshift-hooks.log 2>&1
echo calling $0

readonly lightswitch_cmd=$HOME/usr/bin/lightswitch

lightswitch() {
    "$lightswitch_cmd" "$@"
}


if [ $1 = "period-changed" ]; then
    case $3 in
        daytime) lightswitch light ;;
        transition) [ "$2" = none ] && lightswitch light ;;
        night) lightswitch dark ;;
        none) # Is this a bug? Doc error?? From the docs this shouldn't happen
            case "$2" in
                daytime) lightswitch light ;;
                night) lightswitch light ;;
            esac
            ;;
    esac
fi
