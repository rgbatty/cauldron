{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.editors.emacs;
in {
  options.modules.editors.emacs = {
    enable = mkEnableOption "Emacs";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
  };

  # TODO: Configure Emacs
}
