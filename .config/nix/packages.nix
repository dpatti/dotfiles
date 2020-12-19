with import <nixpkgs> {
  config = {
    allowUnfree = true;
  };
}; [
  # # Sound
  # alsaUtils
  # pulseaudio-ctl

  # # Fonts: Also probably need to do this through arch?
  # # fontconfig
  # # hack-font
  # # inconsolata
  # # noto-fonts-emoji

  # dmenu
  # hello
  # git
  # inetutils
  # neovim
  # rxvt-unicode
  # slock
  # xclip
  # xmonad-with-packages
  # xmobar
  # xterm

  # # X: I'm giving up on running X for now
  # # xorg.xauth
  # # xorg.xf86inputsynaptics
  # # xorg.xf86videointel
  # # xorg.xinit
  # # xorg.xmodmap
  # # xorg.xorgserver
  # # xorg.xrdb
]
