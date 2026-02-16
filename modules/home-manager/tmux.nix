{ config, pkgs, lib, ... }:

{
  programs.tmux = {
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
    ];
    enable = true;
    clock24 = true;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = builtins.readFile ../../dotfiles/tmux/tmux.conf;
  };
}
