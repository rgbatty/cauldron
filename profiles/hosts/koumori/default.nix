{ lib, config, flake, pkgs, home-manager, users, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  users.users.riizu = {
    home = "/Users/riizu";
    shell = pkgs.fish;
    isNormalUser = true;
  };

  home-manager.users.riizu = {
    imports = [ ../../users/riizu ];
  };
}
