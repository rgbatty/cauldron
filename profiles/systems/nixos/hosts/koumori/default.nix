{ lib, config, flake, pkgs, home-manager, users, ... }: {
  imports = [
    ../../core.nix
    ./hardware-configuration.nix
  ];
}
