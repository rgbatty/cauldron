{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.dev.ruby;
in {
  options.modules.dev.ruby = {
    enable = mkEnableOption "Ruby";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };

  # TODO: Configure Ruby
}
