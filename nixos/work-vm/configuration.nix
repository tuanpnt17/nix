{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Ho_Chi_Minh";


  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };
  services.displayManager.ly.enable = true;
  services.displayManager.defaultSession = "none+i3";
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    displayManager.sessionCommands = ''
      xwallpaper --zoom ~/nix/modules/bg/nix-waifu.png
    '';
  };

  powerManagement.cpuFreqGovernor = "performance";

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "caps:escape";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.npham_mantu = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  users.defaultUserShell = pkgs.zsh;

  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  virtualisation.vmware.guest.enable = true;
  virtualisation.vmware.guest.headless = false;


  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim 
    zsh
    wget
    git
    gcc
    open-vm-tools
    xclip
    tmux
    gcc
    pcmanfm
    rofi
    ghostty
    xwallpaper
  ];

  services.openssh.enable = true;

  services.picom = {
    enable = true;
    backend = "glx";
    fade = false;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Garbage Collector Setting
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 7d";

  system.stateVersion = "25.11"; # Did you read the comment?
}

