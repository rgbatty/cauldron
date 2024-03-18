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
    };
  };

  config = mkIf (themeCfg.active != null) (mkMerge [
    (mkIf (themeCfg.wallpaper != null) {})

    (mkIf (themeCfg.loginWallpaper != null) {})
  ]);
}
