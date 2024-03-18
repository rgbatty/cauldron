{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./code
    ./emacs
    ./vim.nix
  ];
}
