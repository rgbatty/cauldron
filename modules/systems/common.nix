{ unstable, nixpkgs-2211, nix, ... }: { lib, config, pkgs, ... }:

with lib;
{
  nix = {
    # package = mkDefault (nix.packages.${pkgs.system}.nix.overrideAttrs (oa: {
    #   version = "${oa.version}_patched";
    #   patches = [./prefer-local.patch];
    # }));
    # package = pkgs.nixFlakes;    

    # registry = {
    #   nixpkgs.flake = unstable;
    #   nixpkgs2211.flake = nixpkgs-2211;
    # };

    settings = {
      auto-optimise-store = mkDefault true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = mkDefault [ "root" "@wheel" ];
    };
  };
  # environment = {
  #   shells = with pkgs; [ bashInteractive fish zsh ];
  #   variables = {
  #     NIXPKGS_ALLOW_UNFREE = "1";
  #   };
  #   systemPackages = with pkgs; [
  #     git
  #     vim
  #   ];
  # };

  # home-manager = {
  #   backupFileExtension = "backup";
  #   sharedModules = [ ../home ];
  #   useGlobalPkgs = true;
  #   useUserPackages = true;
  # };



  #   gc = {
  #     automatic = true;
  #   };

  # };
}
