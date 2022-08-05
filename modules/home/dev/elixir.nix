{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.home.dev.elixir;
in {
  options.modules.home.dev.elixir = {
    enable = mkEnableOption "Elixir";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [];
  };
}
