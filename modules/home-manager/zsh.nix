{
  lib,
  config,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    bat
    zsh
    ripgrep
    fzf
    btop
    starship
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];
    # autosuggestion Configuration Options
    autosuggestion.enable = true;
    autosuggestion.strategy = [
      "history"
      "completion"
    ];
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "z"
      ];
    };
    history = {
      size = 50000;
      save = 50000;
      path = "${config.xdg.dataHome}/zsh/history";
      append = true;
      expireDuplicatesFirst = true;
      share = true;
    };
    shellAliases = {
      dc = "docker-compose";
      rm = "rm -i";
      k = "kubectl";
      v = "nvim";
      f = "fzf";
      fp = "fzf --preview='bat --color=always {}'";
      fv = "nvim $(fzf -m --preview='bat --color=always {}')";
      gcof = "git fetch && git checkout $(git branch | fzf | sed 's/^..//')";
      lzd = "lazydocker";
      slzd = "sudo lazydocker";
    };
    initContent = ''
      eval "$(starship init zsh)"
    '';
  };
}
