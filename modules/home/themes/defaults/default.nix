{ options, config, lib, pkgs, ... }: {
  imports = [
    ./apps

    ./colors.nix
    ./fonts.nix
    ./wallpaper.nix
  ];
}
