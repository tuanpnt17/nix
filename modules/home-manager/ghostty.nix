{ pkgs, ... }: 
{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    enableZshIntegration = true;

    # settings = {
    #   theme = "Catppuccin Mocha";
    #   font-family = "JetBrains Mono";
    #   font-style = "Regular";
    #   font-size = "13";
    #   window-padding-x = "3";
    #   window-padding-y = "3";
    #   window-padding-balance = true;
    #   confirm-close-surface = false;
    #   resize-overlay = "never";
    #   window-decoration = false;
    #   title = "";
    #   cursor-style = "block";
    #   cursor-style-blink = false;
    #   adjust-cursor-thickness = "1";
    #   shell-integration-features = "no-cursor";
    #   background-opacity = "0.9";
    # };
    
  };

  home.file = {
    ".config/ghostty/config" = {
      source = ../../dotfiles/ghostty/config;
    };
  };
}

