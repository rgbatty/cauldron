{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.shell.utilities;
  shellsCfg = config.modules.shell.shells;
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

    programs.fzf = {
      enable = true;
      enableBashIntegration = shellsCfg.bash.enable;
      enableFishIntegration = shellsCfg.fish.enable;
      enableZshIntegration = shellsCfg.zsh.enable;
    };

    programs.zoxide = {
      enable = true;
      enableBashIntegration = shellsCfg.bash.enable;
      enableFishIntegration = shellsCfg.fish.enable;
      enableZshIntegration = shellsCfg.zsh.enable;
    };

    programs.bat = mkIf cfg.modern {
      enable = true;
    };

    programs.navi = mkIf cfg.navi {
      enable = true;
      enableBashIntegration = shellsCfg.bash.enable;
      enableFishIntegration = shellsCfg.fish.enable;
      enableZshIntegration = shellsCfg.zsh.enable;
    };
  };
}
