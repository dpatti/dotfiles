#!/usr/bin/env bash

# I feel like I should be using `-euo pipefail`, but I also need to figure out
# how to get errors to bubble or be logged somewhere instead of just ending the
# X session.
#
# 2023-10: Maybe the below will work?

logs=$HOME/.local/share/profile
mkdir -p "$logs"
exec >& "$logs/log-$(date -Ins)"

function isfile { [ -f "$1" ]; }
function filter {
  while read -r i; do
    if "$@" "$i"; then
      echo "$i"
    fi
  done
}
function runeach {
  while read -r f; do
    echo "$@" "$f"
    "$@" "$f"
    echo "Exit status: $?"
  done
}
function runfiles { filter isfile | runeach "$@"; }

runfiles source <<PROFILES
  /etc/xprofile
  $HOME/.xprofile
PROFILES

runfiles xrdb -merge <<RESOURCES
  /etc/X11/xinit/.Xresources
  $HOME/.Xresources
RESOURCES

echo /etc/X11/xinit/xinitrc.d/?*.sh | runfiles source

xss-lock xsecurelock &
bluetoothctl power on &
dunst &
xmonad --recompile
exec xmonad
