{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.home.dev.rust;
in {
  options.modules.home.dev.rust = {
    enable = mkEnableOption "Rust";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [];
  };

}
