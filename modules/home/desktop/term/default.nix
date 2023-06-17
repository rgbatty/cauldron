{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./iterm.nix
    ./winterm.nix
  ];

  home.packages = with pkgs; [
    kitty
  ];
}
