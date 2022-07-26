{ options, config, lib, pkgs, ... }:

with lib;
let
  themeCfg = config.modules.home.theme;
  cfg = themeCfg.fonts;
in {
  options.modules.home.theme.fonts = with types; {
    mono = {
      name = mkOption { type = str; default = "Monospace"; };
      size = mkOption { type = int; default = 12; };
    };
    sans = {
      name = mkOption { type = str; default = "Sans"; };
      size = mkOption { type = int; default = 10; };
    };
  };

  config = mkIf (cfg != null) (mkMerge [
    {
      # fonts.fontconfig.defaultFonts = {
      #   sansSerif = [ cfg.fonts.sans.name ];
      #   monospace = [ cfg.fonts.mono.name ];
      # };
    }
  ]);
}
