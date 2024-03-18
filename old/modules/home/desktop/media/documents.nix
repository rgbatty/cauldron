{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.home.desktop.media.documents;
in {
  options.modules.home.desktop.media.documents = {
    enable = mkEnableOption "Documents";
    calibre.enable = mkEnableOption "Calibre";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # (mkIf cfg.calibre.enable calibre)
    ];
  };
}
