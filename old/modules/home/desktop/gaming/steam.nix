{ options, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.desktop.gaming.steam;
in {
  options.modules.home.desktop.gaming.steam = {
    enable = mkEnableOption "Steam";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # steam
    ];

    # better for steam proton games
    # systemd.extraConfig = "DefaultLimitNOFILE=1048576";
  };
}
