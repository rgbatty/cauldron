{ options, config, lib, pkgs, ... }:

with lib;
let
  themeCfg = config.modules.home.theme;
in {
  options.modules.home.theme = with types; {
    wallpaper = mkOption { type = (either path null); };

    loginWallpaper = mkOption {
      type = (either path null);
      default = null;

      # TODO: Add filteredImage code - sounds neat
      # default = (if cfg.wallpaper != null
      #  then toFilteredImage cfg.wallpaper "-gaussian-blur 0x2 -modulate 70 -level 5%"
      #  else null);
    };
  };

  config = mkIf (themeCfg.active != null) (mkMerge [
    (mkIf (themeCfg.wallpaper != null) {})

    (mkIf (themeCfg.loginWallpaper != null) {})
  ]);
}
