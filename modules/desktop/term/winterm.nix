{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.term.winterm;
in {
  options.modules.desktop.term.winterm = {
    enable = mkEnableOption "Windows Terminal";
  };

  config = mkIf cfg.enable {
    # TODO: Configure WinTerm dotfiles
  };
}
