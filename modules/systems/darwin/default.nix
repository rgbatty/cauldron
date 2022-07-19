{ self, config, lib, pkgs, ... }:

{
  # Recreate /run/current-system symlink after boot
  # services.activate-system.enable = true;

  services.nix-daemon.enable = true;
  # users.nix.configureBuildUsers = true;

  # environment = {};

  # nix = {
  #   nixPath = [
  #     # "darwin=/etc/nix/inputs/darwin"
  #   ];
  # };
}
