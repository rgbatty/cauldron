{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.dev.python;
in {
  options.modules.dev.python = {
    enable = mkEnableOption "Python";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };

  # TODO: Configure Python
}
