{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.shell.utilities;
  shellsCfg = config.modules.home.shell.shells;
in {
  options.modules.home.shell.utilities = with types; {
    enable = mkEnableOption "Utilities";
    modern = mkEnableOption "Modern Utilities";
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
    ];

    programs.bat = mkIf cfg.modern {
      enable = true;
    };

    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    programs.fzf = {
      enable = true;
      # added via interactiveShellInit instead
      enableFishIntegration = false;
    };

    programs.zoxide = {
      enable = true;
      # added via interactiveShellInit instead
      enableFishIntegration = false;
    };
  };
}
