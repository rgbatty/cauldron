{ config, lib, pkgs, modulesPath, ... }:
{
  # Storage
  # fileSystems = {
  #   "/" = {
  #     device = "/dev/disk/by-label/nixos";
  #     fsType = "ext4";
  #     options = [ "noatime" ];
  #   };
  #   "/boot" = {
  #     device = "/dev/disk/by-label/BOOT";
  #     fsType = "vfat";
  #   };
  # };
  # swapDevices = [ { device = "/dev/disk/by-label/swap"; }];
}
