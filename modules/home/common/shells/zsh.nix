{ config, pkgs, lib, ... }:
let
  cfg = config.modules.home.common.shells.zsh;
  shellAliases = import ./aliases.nix;
in
{
  options = {
    modules.home.common.shells.zsh.enable = lib.mkEnableOption "Enable Zsh";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nix-zsh-completions
    ];

    programs.zsh = {
      inherit shellAliases;

      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;

      history.path = "${config.xdg.dataHome}/zsh/history";
      history.expireDuplicatesFirst = true;
      history.extended = true;
      history.ignoreDups = true;
    };
  };
}
