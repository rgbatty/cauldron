{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.dev.rust;
in {
  options.modules.dev.rust = {
    enable = mkEnableOption "Rust";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };

  # TODO: Configure Rust
}
