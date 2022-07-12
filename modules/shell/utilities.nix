{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.shell.utilities;
  # configDir = config.dotfiles.configDir;
in {
  options.modules.shell.utilities = with types; {
    bat.enable = mkEnableOption "bat";
    exa.enable = mkEnableOption "exa";
    direnv.enable = mkEnableOption "direnv";
    fzf.enable = mkEnableOption "fzf";
    navi.enable = mkEnableOption "navi";
    zoxide.enable = mkEnableOption "zoxide";
  };

  config = {
    programs.direnv = {
      enable = cfg.direnv.enable;
      nix-direnv = {
        enable = cfg.direnv.enable;
      };
    };

    programs.bat.enable = cfg.bat.enable;
    programs.exa.enable = cfg.exa.enable;
    programs.fzf.enable = cfg.fzf.enable;
    programs.navi.enable = cfg.navi.enable;
    programs.zoxide.enable = cfg.zoxide.enable;
  };
}
