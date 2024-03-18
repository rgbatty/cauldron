{ options, config, lib, pkgs, ... }:

with lib;
let
  themeCfg = config.modules.home.theme;
  cfg = themeCfg.gtk;
in {
  options.modules.home.theme.gtk = with types; {
    enable = mkEnableOption;
    theme = mkOption { type = str; default = ""; };
    iconTheme = mkOption { type = str; default = ""; };
    cursorTheme = mkOption { type = str; default = ""; };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      # home.configFile = {
      #   "gtk-3.0/settings.ini".text = ''
      #     [Settings]
      #     ${optionalString (cfg.theme != "")
      #       ''gtk-theme-name=${cfg.theme}''}
      #     ${optionalString (cfg.iconTheme != "")
      #       ''gtk-icon-theme-name=${cfg.iconTheme}''}
      #     ${optionalString (cfg.cursorTheme != "")
      #       ''gtk-cursor-theme-name=${cfg.cursorTheme}''}
      #     gtk-fallback-icon-theme=gnome
      #     gtk-application-prefer-dark-theme=true
      #     gtk-xft-hinting=1
      #     gtk-xft-hintstyle=hintfull
      #     gtk-xft-rgba=none
      #   '';
      #   # GTK2 global theme (widget and icon theme)
      #   "gtk-2.0/gtkrc".text = ''
      #     ${optionalString (cfg.theme != "")
      #       ''gtk-theme-name="${cfg.theme}"''}
      #     ${optionalString (cfg.iconTheme != "")
      #       ''gtk-icon-theme-name="${cfg.iconTheme}"''}
      #     gtk-font-name="Sans ${toString(cfg.fonts.sans.size)}"
      #   '';
      #   # QT4/5 global theme
      #   "Trolltech.conf".text = ''
      #     [Qt]
      #     ${optionalString (cfg.gtk.theme != "")
      #       ''style=${cfg.gtk.theme}''}
      #   '';
      # };
    }
  ]);
}
