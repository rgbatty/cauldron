{ pkgs, ... }:
{
  home.packages = with pkgs; [
    manix
    nix-index
  ];

  nixpkgs.config.allowUnfree = true;
}
