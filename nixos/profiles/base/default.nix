{ inputs, pkgs, config, lib, users, ... }:

with lib;
let
  mapUsersToAttrs = users: fn: builtins.listToAttrs (
    map (user: { name = user; value = fn(user); }) users
  );
in {
  imports = [  ];

  environment.variables.NIXPKGS_ALLOW_UNFREE = "1";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";

    # Improve nix store disk usage
    settings.auto-optimise-store = true;
    optimise.automatic = true;

    gc = {
      automatic = true;
      dates = "daily";
      persistent = true;
      randomizedDelaySec = "30min";
    };
  };

  system.stateVersion = "21.11";

  time.timeZone = mkDefault "America/Denver";

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
    cached-nix-shell
    git
    vim
    wget
    gnumake
    unzip

    dosfstools
    gptfdisk
    iputils
    usbutils
    utillinux
  ];

  users.users = mapUsersToAttrs users (user: {
    name = user;
    isNormalUser = true;
  });

  home-manager.users = mapUsersToAttrs users (user: {
    imports = [ ../../../modules ../../../profiles/users/${user} ];
  });
}
