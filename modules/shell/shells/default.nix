{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./bash
    ./fish
    ./zsh
  ];
}
