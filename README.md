# Redshift hooks

Hooks to enhance [redshift](//github.com/jonls/redshift)'s abilities.

* `brightness.sh` - Set screen backlight brightness according to time of day.
* `colorscheme.sh` - Live-reload terminal colorscheme according to time of day

## Installation

For each script, copy from `hooks/script_name` to
`.config/redshift/hooks/script_name`. Each script may have its own installation
instructions.

## `brightness.sh`

Set screen backlight brightness according to time of day.

The default brightnesses for day, transition and night are 90, 60, 35, and the
default fade time is one hour. If you wish to alter them, you can find them at
the top of the script.

### Using `acpi-backlight`

By default, `brightness.sh` uses
[`acpi-brightness`](//github.com/qualiaa/acpi-brightness). If using it, you will
have to change the line 

    readonly brightness=$HOME/usr/bin/brightness 

to point to the location of the `acpi-brightness` script.

### Using `xbacklight`

If you wish to use `xbacklight`, you will need to replace the `brightness`
function with something like

```sh
function brightness() {
    local seconds=${1:-0}
    local steps=$((seconds * 100))
    xbacklight -time $((seconds*1000)) -set $percent
}
```

However, I have not tested this as `xbacklight` does not work on my system.

## `colorscheme.sh`

Live-reload terminal colorscheme according to time of day.

By default, this switches between solarized-light and solarized dark

### With URxvt

* **Install 
[`urxvt-config-reload`](//github.com/qualiaa/urxvt-config-reload)**
* **Copy `Xresources.d` to `~/.Xresources.d`**
* **Add `#include ".Xresources.d/solarized"` to `.Xresources` file**
* (optional) **Copy `dircolors.ansi-dark` from 
[seebi/dircolors-solarized](//github.com/seebi/dircolors-solarized/) to 
`~/.dircolors.ansi-dark`, and the same for `dircolors.ansi-light`.**

### With other terminals

This currently only works for URxvt using
[`urxvt-config-reload`](//github.com/qualiaa/urxvt-config-reload), though you
may be able to rewrite the `update_terminal` to work with your terminal of
choice.

Note that for best behaviour you need to change the colorscheme of running
terminals, and also the global configuration for new terminals. Some terminals
may automatically reload changes to their configuration, but in general to
change running terminals you need to send control codes directly. Someone has
already done this
[for Gnome terminal](https://gist.github.com/codeforkjeff/1397104).

## Related Projects

* [`acpi-brightness`](//github.com/qualiaa/acpi-brightness)
* [`urxvt-config-reload`](//github.com/qualiaa/urxvt-config-reload)

## Acknowledgements

* Solarized Xresources files from
[solarized/xresources](https://github.com/solarized/xresources)


## Licence

All code is licensed under the GNU General Public Licence v3.0.
