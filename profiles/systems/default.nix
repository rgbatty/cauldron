{ inputs, lib, config, flake, pkgs, home-manager, ... }:

with lib;
{
  environment = {
    shells = with pkgs; [ bashInteractive fish zsh ];
    variables = {
      SHELL = "${pkgs.fish}/bin/fish";
      NIXPKGS_ALLOW_UNFREE = "1";
    };
    systemPackages = with pkgs; [
      git
      vim
    ];
  };

  home-manager = {
    sharedModules = [ ../../modules ];
  };

  nix = {
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
      keep-derivations = true
      keep-outputs = true
    '';

    gc = {
      automatic = true;
      # TODO: Not in Darwin
      # dates = "daily";
      # persistent = true;
      # randomizedDelaySec = "30min";
    };

    package = pkgs.nixFlakes;
  };


  # TODO: Nix-Darwin doesn't like this...
  # time.timeZone = mkDefault "America/Denver";
}
