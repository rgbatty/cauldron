{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.services.docker;
in {
  options.modules.home.services.docker = {
    enable = mkEnableOption "Docker";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };

  # TODO: Configure Docker
}
