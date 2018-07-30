#!/usr/bin/env bash

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

runfiles xmodmap <<MODMAPS
  /etc/X11/xinit/.Xmodmap
  $HOME/.Xmodmap
MODMAPS

echo /etc/X11/xinit/xinitrc.d/?*.sh | runfiles source

urxvtd --quiet --opendisplay --fork
cbatticon &
dropbox &
xmonad --recompile
exec xmonad
