{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.dev.go;
in {
  options.modules.dev.go = {
    enable = mkEnableOption "GoLang";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];

    # TODO: Configure golang
  };
}
