{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.home.desktop.media.spotify;
in {
  options.modules.home.desktop.media.spotify = {
    enable = mkEnableOption false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # spotify
    ];
  };
}
