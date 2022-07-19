{ pkgs, config, lib, ... }:

with lib;
{
  imports = [];

  environment.variables.NIXPKGS_ALLOW_UNFREE = "1";

  nix =
    let
      # filteredInputs = filterAttrs (n: _: n != "self") inputs;
      # nixPathInputs  = mapAttrsToList (n: v: "${n}=${v}") filteredInputs;
      # registryInputs = mapAttrs (_: v: { flake = v; }) filteredInputs;
    in {
      extraOptions = "experimental-features = nix-command flakes";

      # package = pkgs.nixFlakes;
      gc = {
        # automatic = true;
        # dates = "daily";
        # persistent = true;
        # randomizedDelaySec = "30min";
      };

      nixPath = [];

      # registry = registryInputs // { dotfiles.flake = inputs.self; };
      # settings = {
      #   substituters = [
      #     "https://nix-community.cachix.org"
      #   ];
      #   trusted-public-keys = [
      #     "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      #   ];
      #   auto-optimise-store = true;
      # };
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
  ];
}
