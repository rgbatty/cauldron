{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.shell.starship;
  shellsCfg = config.modules.home.shell.shells;
in {
  options.modules.home.shell.starship = {
    enable = mkEnableOption "Starship";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ starship ];

    programs.starship = {
      enable = true;
      enableBashIntegration = shellsCfg.bash.enable;
      enableFishIntegration = shellsCfg.fish.enable;
      enableZshIntegration = shellsCfg.zsh.enable;

      # TODO: Configure Starship
      settings = {
        add_newline = false;
      };
    };
  };

}
