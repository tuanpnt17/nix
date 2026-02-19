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
    fzf
    fd
    tmux
    curl
    eza
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
      # common
      dc = "docker-compose";
      rm = "rm -i";
      k = "kubectl";
      v = "nvim";

      # fzf
      f = "fzf";
      fp = "fzf --preview='bat --style=numbers --color=always {}'";
      fv = "nvim $(fzf -m --preview='bat --color=always {}')";

      # lazy
      lg = "lazygit";
      lzd = "lazydocker";
      oo = "nvim ~/vaults/personal/Start.md";

      # Eza
      ls = "eza -lh --group-directories-first --icons=auto";
      lt = "eza --tree --level=2 --long --icons --git";

      # Others
      c = "clear";
      ex = "exit";
      cd = "zd";
    };
    initContent = ''
      eval "$(starship init zsh)"
      zd() {
        if [ $# -eq 0 ]; then
          builtin cd ~ && return
        elif [ -d "$1" ]; then
          builtin cd "$1"
        else
          z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
        fi
      }
    '';
  };

  home.sessionPath = [
    "/home/npham_mantu/.dotnet/tools"
  ];

home.sessionVariables = {
  DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
};
}
