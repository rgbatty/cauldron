{ config, flake, pkgs, ... }: {
  imports = [
    ../../profiles/base
    ./hardware-configuration.nix
  ];

  users.users = {
    riizu = {
      name = "riizu";
      isNormalUser = true;
    };
  };
}
