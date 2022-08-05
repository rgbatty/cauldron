{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.home.dev.go;
in {
  options.modules.home.dev.go = {
    enable = mkEnableOption "GoLang";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [];
  };
}
