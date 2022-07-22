{ inputs, config, lib, pkgs, ... }: {
  # TODO: Find a way to auto-import the whole modules directory
  imports = [
    ./home.nix
    ./nix.nix

    ./desktop
    ./dev
    ./editors
    ./hardware
    ./services
    ./shell
    ./themes
  ];
}
