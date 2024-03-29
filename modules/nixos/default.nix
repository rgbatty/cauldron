{ lib, ... }:

{
  imports = [
    ./nvidia.nix
    ./wayland.nix
    ./x11.nix
  ];
}
