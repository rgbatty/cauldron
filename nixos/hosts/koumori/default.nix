{ lib, config, flake, pkgs, home-manager, users, ... }: {
  imports = [
    ../../profiles/base
    ./hardware-configuration.nix
  ];
}
