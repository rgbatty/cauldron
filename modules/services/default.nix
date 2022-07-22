{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./docker.nix
    ./ssh.nix
    ./vaultwarden.nix
  ];
}
