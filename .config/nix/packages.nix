with import <nixpkgs> {}; {
  # xorg = with xorg; {
  #   inherit
  #     xorgserver
  #     xf86inputsynaptics
  #     xf86videointel
  #   ;
  # };
  # services.xserver.enable = true;

  inherit
    hello
    git
    neovim
    xmonad-with-packages
    xmobar
  ;
}
