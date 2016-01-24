#!/bin/sh

profiles="/etc/xprofile $HOME/.xprofile"
resources="/etc/X11/xinit/.Xresources $HOME/.Xresources"
modmap="/etc/X11/xinit/.Xmodmap $HOME/.Xmodmap"

for f in $profiles; do
  [ -f $f ] && source $f
done

for f in $resources; do
  [ -f $f ] && xrdb -merge $f
done

for f in $modmap; do
  [ -f $f ] && xmodmap $f
done

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
fi

# exec i3
exec fluxbox
