{ config, pkgs, lib, ...}:

{
  # Install Neovim and dependencies
  home.packages = with pkgs; [
    # Tools required for Telescope
    ripgrep
    fd
    fzf

    # Needed for lazy.nvim
    nodejs
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];

    extraPackages = with pkgs; [
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/npham_mantu/nix/dotfiles/nvim";
    recursive = true;
  };
	
}

