{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.home.desktop.term.winterm;
in {
  options.modules.home.desktop.term.winterm = {
    enable = mkEnableOption "Windows Terminal";
  };

  config = mkIf cfg.enable {
  };
}
