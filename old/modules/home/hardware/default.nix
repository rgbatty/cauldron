{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./qmk.nix
    ./zmk.nix
  ];
}
