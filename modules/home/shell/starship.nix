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
        # battery.display.threshold = 25;
        # directory.fish_style_pwd_dir_length = 1;
        # directory.truncation_length = 2;
        # gcloud.disabled = true;
        # memory_usage.disabled = true;
      };
    };
  };

}
