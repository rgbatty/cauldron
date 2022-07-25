{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.dev.python;
in {
  options.modules.home.dev.python = {
    enable = mkEnableOption "Python";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };

  # TODO: Configure Python
}
