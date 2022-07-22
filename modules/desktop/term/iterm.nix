{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.term.iterm;
in {
  options.modules.desktop.term.iterm = {
    enable = mkEnableOption "iTerm";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      iterm2
    ];

    # TODO: Configure iTerm
  };
}
