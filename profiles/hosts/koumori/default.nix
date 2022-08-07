{ lib, config, flake, pkgs, home-manager, users, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  users.users.rbatty = {
    home = "/Users/rbatty";
    shell = pkgs.fish;
    isNormalUser = true;
  };

  home-manager.users.rbatty = {
    imports = [ ../../users/rbatty ];
  };
}
