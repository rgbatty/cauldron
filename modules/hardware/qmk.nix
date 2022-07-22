{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.hardware.qmk;
in {
  options.modules.hardware.qmk = {
    enable = mkEnableOption "QMK";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };

  # TODO: Configure QMK
}
