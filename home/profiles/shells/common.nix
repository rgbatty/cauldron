{ config, lib, pkgs, ... }:
{
  imports = [

    ./utilities/bat.nix
    ./utilities/fzf.nix
    ./utilities/navi.nix
    ./utilities/zoxide.nix

    ./starship.nix
  ];
}
