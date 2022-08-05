# TODO: Media Configuration
# * Implement documents
# * Implement recording
# * Implement spotify

{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./documents.nix
    ./recording.nix
    ./spotify.nix
  ];
}
