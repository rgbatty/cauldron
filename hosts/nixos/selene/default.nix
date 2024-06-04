# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../../modules/nixos
  ];

  modules.nixos = {
    gaming.enable = true;
    nvidia.enable = true;
    synergy.enable = true;
    # wayland.enable = true;
    x11.enable = true;
  };

  networking.hostName = "selene"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  networking.firewall.allowedTCPPorts = [ 24800 4242 ];
  networking.firewall.allowedUDPPorts = [ 24800 4242 ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
