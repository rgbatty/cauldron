# TODO: Gaming Configuration
# * Add Steam

{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./steam.nix
  ];
}
