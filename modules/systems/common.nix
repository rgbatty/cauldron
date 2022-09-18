{ inputs, lib, config, flake, pkgs, home-manager, ... }:

with lib;
{
  environment = {
    shells = with pkgs; [ bashInteractive fish zsh ];
    variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };
    systemPackages = with pkgs; [
      git
      vim
    ];
  };

  home-manager = {
    backupFileExtension = "backup";
    sharedModules = [ ../home ];
    useGlobalPkgs = true;
    useUserPackages = true;
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
    };

    package = pkgs.nixFlakes;
  };
}
