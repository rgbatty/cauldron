{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.hardware.qmk;
in {
  options.modules.home.hardware.qmk = {
    enable = mkEnableOption "QMK";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };
}
