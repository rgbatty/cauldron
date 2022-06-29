{ config, lib, pkgs, ... }:
{
  imports = [
    # Sets nrdxp.cachix.org binary cache which just speeds up some builds
    # ../cachix
    ./packages.nix
    ../direnv.nix
    ../git
    ../ssh.nix
    ../shells/bash

    # TODO: Nix isn't configured through home manager
    # ../nix.nix
  ];

  # fonts.fonts = with pkgs; [ powerline-fonts dejavu_fonts ];
    # fonts-firacode

}
