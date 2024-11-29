{ config, pkgs, lib, ... }:
{
  imports = [
    ./bash.nix 
    ./fish.nix
    ./zsh.nix
    ./utils/bat.nix
    ./utils/direnv.nix
    ./utils/eza.nix
    ./utils/fzf.nix
    ./utils/git
    ./utils/ripgrep.nix
    ./utils/starship.nix
    ./utils/tealdeer.nix
    ./utils/zoxide.nix
  ];
}
