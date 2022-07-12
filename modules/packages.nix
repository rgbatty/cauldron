{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.packages;

  enhancements = with pkgs; [
    bat
    bottom
    exa
    fd
    fzf
    htop
    ripgrep
    zoxide
    tealdeer
  ];

  networking = with pkgs; [
    curl
    dnsutils
    jq
    nettools
    nmap
    wget
    whois
  ];

  system = with pkgs; [
    neofetch
    tree
    unzip
    xclip
  ];

in {
  options.modules.packages = with types; {
    # enable = mkEnableOption "on";
  };

  config = {
    home.packages = with pkgs; [
      autoconf
      automake
      binutils
      colordiff
      coreutils
      direnv
      gcc
      moreutils
      tmux
    ]
    ++ networking
    ++ system
    ++ enhancements;
  };

}
