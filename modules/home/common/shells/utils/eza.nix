{ config, pkgs, lib, ... }:

{
  programs.eza = {
    enable = true;
    # enableFishIntegration = true; # not in hm-23.11
    # git = true;
    # icons = true;
  };
}