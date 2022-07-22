{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./apps
    ./browsers
    ./gaming
    ./media
    ./term
  ];
}
