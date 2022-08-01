{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./yabai
    ./skhd
    ./docker.nix
    ./ssh.nix
    ./vaultwarden.nix
  ];
}
