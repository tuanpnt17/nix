{ config, pkgs, ... }:

{
  imports = [
    ./../../modules/home-manager/default.nix
  ];
  home.username = "npham_mantu";
  home.homeDirectory = "/home/npham_mantu";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    curl
    fd
    lazygit
    fzf
    tmux
    ghostty
    tree-sitter
    zip
    unzip
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "Tuan Pham";
        email = "tuanpnt17@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };

  xdg.configFile."qtile" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/npham_mantu/nix/dotfiles/qtile";
    recursive = true;
  };

}
