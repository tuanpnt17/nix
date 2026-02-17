{ config, pkgs, ... }:

{
  imports = [
    ./../../modules/home-manager/default.nix
    ./../../modules/home-manager/alacritty.nix
    ./langs.nix
  ];
  home.username = "npham_mantu";
  home.homeDirectory = "/home/npham_mantu";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    neofetch
    lazygit
    ghostty
    alacritty
    tree-sitter
    zip
    unzip
    yazi
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

}
