{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.dev.node;
in {
  options.modules.home.dev.node = {
    enable = mkEnableOption "Node";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs_latest
      yarn
    ];
  };

  # TODO: Configure Node
}
