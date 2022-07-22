{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.dev.elixir;
in {
  options.modules.dev.elixir = {
    enable = mkEnableOption "Elixir";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];

    # TODO: Configure elixir
  };
}
