#!/usr/bin/env sh

function isfile { [ -f $1 ]; }
function filter {
  while read -r i; do
    if "$@" "$i"; then
      echo $i
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

# Set left-win as the compose key
# Note this must happen *before* xmodmap
setxkbmap -option compose:lwin

runfiles xmodmap <<MODMAPS
  /etc/X11/xinit/.Xmodmap
  $HOME/.Xmodmap
MODMAPS

echo /etc/X11/xinit/xinitrc.d/?*.sh | runfiles source

# exec i3
cbatticon &
dropbox &
xscreensaver &
# shutter --min_at_startup &
exec fluxbox
