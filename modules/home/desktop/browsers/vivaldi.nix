{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.home.desktop.browsers.vivaldi;
in {
  options.modules.home.desktop.browsers.vivaldi = {
    enable = mkEnableOption "Vivaldi";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      #vivaldi
    ];
  };
}
