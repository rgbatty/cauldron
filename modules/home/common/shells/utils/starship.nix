{ config, pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    # enableBashIntegration = shellsCfg.bash.enable;
    enableFishIntegration = true;
    # enableZshIntegration = shellsCfg.zsh.enable;

    settings = {
      add_newline = false;
    };
  };
}