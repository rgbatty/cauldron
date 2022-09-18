{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.hardware.zmk;
in {
  options.modules.home.hardware.zmk = {
    enable = mkEnableOption "ZMK";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };
}
