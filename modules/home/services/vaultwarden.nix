# TODO: Vaultwarden Configuration

{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.services.vaultwarden;
in {
  options.modules.home.services.vaultwarden = {
    enable = mkEnableOption "Vaultwarden";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };
}
