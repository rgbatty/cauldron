{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.hardware.zmk;
in {
  options.modules.hardware.zmk = {
    enable = mkEnableOption "ZMK";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };

  # TODO: Configure ZMK
}
