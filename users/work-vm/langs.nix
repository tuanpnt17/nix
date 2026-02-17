{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Python
    python3

    # Node.js
    nodejs_latest

    # Golang
    go
    golangci-lint

    # Rust
    cargo # Rust package manager, neovim pack install

    # Zig
    zig_0_15

    # Java
    openjdk17 # Java JDK

    # Dotnet
    dotnet-sdk
    csharpier
    dotnet-ef
  ];

  # Other settings
  home.sessionVariables = {
    # Python
    PYTHONSTARTUP = "${pkgs.python3}/lib/python3.13/site-packages";

    GOROOT = "${pkgs.go}";
    GOPATH = "/home/npham_mantu/go";
    GOBIN = "/home/npham_mantu/go/bin";
    # Node.js
    NODE_PATH = "~/.npm-global/lib/node_modules";

    # Rust
    CARGO_HOME = "~/.cargo";
    PATH = "${pkgs.go}/bin:$HOME/.npm-global/bin:$PATH";

  };

}
