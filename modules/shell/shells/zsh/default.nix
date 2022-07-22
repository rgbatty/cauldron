{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.shell.shells.zsh;

  shellAliases = (import ../common/aliases.nix)
  // (import ../common/abbrs.nix);
in {
  options.modules.shell.shells.zsh = with types; {
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
      # TODO: Possibly slow completion?
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;

      history.path = "${config.xdg.dataHome}/zsh/history";
      history.expireDuplicatesFirst = true;
      history.extended = true;
      history.ignoreDups = true;
    };
  };
}
