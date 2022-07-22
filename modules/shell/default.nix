{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./git
    ./shells
    ./starship.nix
    ./utilities.nix
  ];
}
