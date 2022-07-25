{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.media.spotify;
in {
  options.modules.desktop.media.spotify = {
    enable = mkEnableOption false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # TODO: Doesn't support Darwin
      # spotify
    ];

    # TODO: Configure spotify
  };
}
