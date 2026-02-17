{ config, ...}:

{
  xdg.configFile."qtile" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/npham_mantu/nix/dotfiles/qtile";
    recursive = true;
  };
}

