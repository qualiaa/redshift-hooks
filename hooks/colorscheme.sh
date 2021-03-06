#!/usr/bin/env sh

set -eu

exec >> ~/.redshift-hooks.log 2>&1

readonly colorscheme_file="$HOME/.Xresources.d/solarized"

update_terminal() {
    xrdb -merge "$colorscheme_file"
    pkill -SIGUSR1 urxvt
    if command i3-msg 2>/dev/null; then
        i3-msg reload 2>/dev/null
    fi
}

solarized_light() {
    sed -i '/^#include/s/solarized-dark/solarized-light/
        ' "$colorscheme_file"
    ln -sf ~/.dircolors.ansi-light ~/.dircolors
    update_terminal
}

solarized_dark() {
    sed -i '/^#include/s/solarized-light/solarized-dark/
        ' "$colorscheme_file"
    ln -sf ~/.dircolors.ansi-dark ~/.dircolors
    update_terminal
}

if [ "$1" = period-changed ]; then
    echo $(date +"%y-%m-%d %H:%M:%S") $@
    case $3 in
        daytime)
            solarized_light
            ;;
        transition)
            if [ "$2" = none ]; then
                solarized_light
            fi
            ;;
        night)
            solarized_dark
    esac
fi
