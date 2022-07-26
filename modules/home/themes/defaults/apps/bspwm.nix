{ options, config, lib, pkgs, ... }:

with lib;
let
  themeCfg = config.modules.home.theme;
  cfg = themeCfg.bspwm;
in {
  options.modules.home.theme.bspwm = with types; {
    enable = mkEnableOption;
  };

  config = mkIf cfg.enable (mkMerge [
    # (mkIf config.modules.desktop.bspwm.enable {
    #   home.configFile."bspwm/rc.d/05-init" = {
    #     text = "$XDG_CONFIG_HOME/xtheme.init";
    #     executable = true;
    #   };
    # })
  ]);
}
