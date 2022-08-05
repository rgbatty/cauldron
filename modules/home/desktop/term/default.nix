# TODO: Terminal Configuration
# * Configure iTerm2
# * Configure winterm

{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./iterm.nix
    ./winterm.nix
  ];
}
