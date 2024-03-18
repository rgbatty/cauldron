{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./documents.nix
    ./recording.nix
    ./spotify.nix
  ];
}
