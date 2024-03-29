{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.home.desktop.term.iterm;
in {
  options.modules.home.desktop.term.iterm = {
    enable = mkEnableOption "iTerm";
  };

  config = mkIf (cfg.enable && pkgs.stdenv.isDarwin) {
    home.packages = with pkgs; [
      iterm2
    ];
  };
}
