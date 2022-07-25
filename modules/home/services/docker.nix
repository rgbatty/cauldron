{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.services.docker;
in {
  options.modules.services.docker = {
    enable = mkEnableOption "Docker";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };

  # TODO: Configure Docker
}
