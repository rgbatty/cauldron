{ config, lib, pkgs, ... }:
let
  shellAliases = (import ../aliases.nix)
  // (import ../abbrs.nix);
in
{
  imports = [../common.nix];

  programs.zsh = {
    inherit shellAliases;

    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;

    history.path = "${config.xdg.dataHome}/zsh/history";
    history.expireDuplicatesFirst = true;
    history.extended = true;
    history.ignoreDups = true;
  };
}
