{ inputs, pkgs, config, lib, users, ... }:

with lib;
{
  imports = [ ../common.nix ];

  nix = {
    settings.trusted-users = [ "root" "@wheel" ];
  };

  system.stateVersion = "21.11";

  ## Some reasonable, global defaults
  # This is here to appease 'nix flake check' for generic hosts with no
  # hardware-configuration.nix or fileSystem config.
  fileSystems."/".device = mkDefault "/dev/disk/by-label/nixos";

  # The global useDHCP flag is deprecated, therefore explicitly set to false
  # here. Per-interface useDHCP will be mandatory in the future, so we enforce
  # this default behavior here.
  networking.useDHCP = mkDefault false;

  # Use the latest kernel
  boot = {
    # kernelPackages = mkDefault pkgs.linuxKernel.packages.linux_5_16;
    loader = {
      efi.canTouchEfiVariables = mkDefault true;
      systemd-boot.configurationLimit = 10;
      systemd-boot.enable = mkDefault true;
    };
  };

  # Just the bear necessities...
  environment.systemPackages = with pkgs; [
    bind
    wget
    gnumake
    unzip
    dosfstools
    gptfdisk
    iputils
    usbutils
    utillinux
  ];
}
