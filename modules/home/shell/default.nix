{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./git
    ./shells
    ./nix.nix
    ./starship.nix
    ./utilities.nix
  ];
}
