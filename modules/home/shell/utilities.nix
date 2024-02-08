# Utilities
# Fish Integrations
# - Manually via interactiveShellInit for performance

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
      ripgrep
      tealdeer
      zoxide
    ] ++ pkgs.lib.optionals (cfg.modern) [
      bat
      bottom
      # exa - replace with eza?
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
      enableFishIntegration = false;
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = false;
    };
  };
}
