{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.home.theme;
in {
  config = mkIf (cfg.active == "dracula") (mkMerge [
    # Desktop-agnostic configuration
    {
      modules = {
        home = {
          theme = {
            wallpaper = mkOption { default = ./config/wallpaper.png; };
            # gtk = {
            #   theme = "Dracula";
            #   iconTheme = "Paper";
            #   cursorTheme = "Paper";
            # };
            fonts = {
              sans.name = "Fira Sans";
              mono.name = "Fira Code";
            };
            colors = {
              black         = "#1E2029";
              red           = "#ffb86c";
              green         = "#50fa7b";
              yellow        = "#f0c674";
              blue          = "#61bfff";
              magenta       = "#bd93f9";
              cyan          = "#8be9fd";
              silver        = "#e2e2dc";
              grey          = "#5B6268";
              brightred     = "#de935f";
              brightgreen   = "#0189cc";
              brightyellow  = "#f9a03f";
              brightblue    = "#8be9fd";
              brightmagenta = "#ff79c6";
              brightcyan    = "#0189cc";
              white         = "#f8f8f2";

              types.fg      = "#bbc2cf";
              types.panelbg = "#21242b";
              types.border  = "#1a1c25";
            };
          };
        };

        # shell.zsh.rcFiles  = [ ./config/zsh/prompt.zsh ];
        # desktop.browsers = {
        #   firefox.userChrome = concatMapStringsSep "\n" readFile [
        #     ./config/firefox/userChrome.css
        #   ];
        #   qutebrowser.userStyles = concatMapStringsSep "\n" readFile
        #     (map toCSSFile [
        #       ./config/qutebrowser/userstyles/monospace-textareas.scss
        #       ./config/qutebrowser/userstyles/stackoverflow.scss
        #       ./config/qutebrowser/userstyles/xkcd.scss
        #     ]);
        # };
      };
    }

    # Desktop (X11) theming
    # (import ./xserver.nix)
  ]);
}
