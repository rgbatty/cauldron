{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    # TODO: must come from unstable channel
    # alejandra
    autoconf
    automake
    bat
    binutils
    colordiff
    coreutils
    curl
    direnv
    dnsutils
    fd
    htop
    fish
    fzf
    gcc
    git
    bottom
    jq
    manix
    moreutils
    nix-index
    neofetch
    nettools
    nmap
    ripgrep
    skim
    tealdeer
    tmux
    tree
    whois
    wget
    unzip
    xclip
    zoxide
  ];
}
