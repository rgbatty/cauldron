{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./iterm.nix
    ./winterm.nix
  ];
}
