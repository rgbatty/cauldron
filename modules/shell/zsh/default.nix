{ config, lib, pkgs, ... }:
let
  shellAliases = (import ../common/aliases.nix)
  // (import ../common/abbrs.nix);
in
{
  home.packages = [ pkgs.zsh ];

  programs.zsh = {
    inherit shellAliases;

    # TODO: Add zimfw/decide if needed

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

  programs.fzf.enableZshIntegration = true;
  programs.navi.enableZshIntegration = true;
  programs.zoxide.enableZshIntegration = true;
  programs.starship.enableZshIntegration = true;
}
