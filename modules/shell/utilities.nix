{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.shell.utilities;
  # configDir = config.dotfiles.configDir;
in {
  options.modules.shell.utilities = with types; {
    enable = mkEnableOption "Utilities";
    modern = mkEnableOption "Modern Utilities";
    navi = mkEnableOption "navi";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fd
      fzf
      navi
      ripgrep
      tealdeer
      zoxide
    ] ++ pkgs.lib.optionals (cfg.modern) [
      bat
      bottom
      exa
      fd
      just
    ] ++ pkgs.lib.optionals (cfg.navi) [
      navi
    ];

    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    programs.fzf.enable = true;
    programs.zoxide.enable = true;

    programs.bat.enable = cfg.modern;
    programs.navi.enable = cfg.navi;
  };
}
