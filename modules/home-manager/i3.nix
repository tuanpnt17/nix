
{ config, pkgs, lib, ...}:

{
  # xsession.windowManager.i3 = {
  #   enable = true;
  # };

  home.file = {
    ".config/i3/config" = {
      source = ../../dotfiles/i3/config;
    };
  };
}

