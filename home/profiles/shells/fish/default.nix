{ config, lib, pkgs, ... }:
let
  shellAbbrs = import ../abbrs.nix;
  shellAliases = import ../aliases.nix;
in
{
  imports = [../common.nix];

  # TODO: How do we get fisher?
  # jorgebucaran/fisher
  # rstacruz/fish-asdf
  # jorgebucaran/autopair.fish
  # franciscolourenco/done
  # danhper/fish-ssh-agent
  # PatrickF1/fzf.fish
  # wfxr/forgit
  # dracula/fish
  home.packages = with pkgs; [
    fishPlugins.forgit
    fishPlugins.fzf-fish
  ];

  programs.fish = {
    inherit shellAbbrs shellAliases;
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
  };
}
