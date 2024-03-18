{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.shell.shells.zsh;

  shellAliases = import ../common/aliases.nix;
in {
  options.modules.home.shell.shells.zsh = with types; {
    enable = mkEnableOption "zsh";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zsh
      nix-zsh-completions
    ];

    programs.zsh = {
      inherit shellAliases;

      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      enableAutosuggestions = true;

      history.path = "${config.xdg.dataHome}/zsh/history";
      history.expireDuplicatesFirst = true;
      history.extended = true;
      history.ignoreDups = true;
    };
  };
}
