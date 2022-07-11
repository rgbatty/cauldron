{ config, lib, pkgs, ... }:
let
  coreModules = [
    ./packages.nix
    ./git
    ./nix.nix
    ./home-manager.nix

    ../services/ssh.nix
    ../shell/bash
    ../shell/starship.nix
  ];

  linuxModules = [

  ];

in {
  imports = coreModules ++ linuxModules;

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.bat.enable = true;
  programs.fzf.enable = true;
  programs.navi.enable = true;
  programs.zoxide.enable = true;
}
