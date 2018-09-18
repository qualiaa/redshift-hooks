#!/usr/bin/env sh

set -eu

exec >> ~/.redshift-hooks.log 2>&1

readonly colorscheme_file="$HOME/.Xresources.d/solarized"

function update_terminal() {
    xrdb -merge "$colorscheme_file"
    pkill -SIGUSR1 urxvt
}

function solarized_light() {
    sed -i '/^#include/s/solarized-dark/solarized-light/
        ' "$colorscheme_file"
    ln -sf ~/.dircolors.ansi-light ~/.dircolors
    update_terminal
}

function solarized_dark() {
    sed -i '/^#include/s/solarized-light/solarized-dark/
        ' "$colorscheme_file"
    ln -sf ~/.dircolors.ansi-dark ~/.dircolors
    update_terminal
}

if [[ $1 == period-changed ]]; then
    echo $@
    case $3 in
        daytime)
            solarized_light
            ;;
        transition)
            if [[ "$2" == none ]]; then
                solarized_light
            fi
            ;;
        night)
            solarized_dark
    esac
fi
