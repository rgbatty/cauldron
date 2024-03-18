{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.home.theme.colors;
in {
  options.modules.home.theme.colors = with types; {
    black         = mkOption { type = str; default = "#000000"; }; # 0
    red           = mkOption { type = str; default = "#FF0000"; }; # 1
    green         = mkOption { type = str; default = "#00FF00"; }; # 2
    yellow        = mkOption { type = str; default = "#FFFF00"; }; # 3
    blue          = mkOption { type = str; default = "#0000FF"; }; # 4
    magenta       = mkOption { type = str; default = "#FF00FF"; }; # 5
    cyan          = mkOption { type = str; default = "#00FFFF"; }; # 6
    silver        = mkOption { type = str; default = "#BBBBBB"; }; # 7
    grey          = mkOption { type = str; default = "#888888"; }; # 8
    brightred     = mkOption { type = str; default = "#FF8800"; }; # 9
    brightgreen   = mkOption { type = str; default = "#00FF80"; }; # 10
    brightyellow  = mkOption { type = str; default = "#FF8800"; }; # 11
    brightblue    = mkOption { type = str; default = "#0088FF"; }; # 12
    brightmagenta = mkOption { type = str; default = "#FF88FF"; }; # 13
    brightcyan    = mkOption { type = str; default = "#88FFFF"; }; # 14
    white         = mkOption { type = str; default = "#FFFFFF"; }; # 15

    # Color classes
    types = {
      bg        = mkOption { type = str; default = cfg.black; };
      fg        = mkOption { type = str; default = cfg.white; };
      panelbg   = mkOption { type = str; default = cfg.types.bg; };
      panelfg   = mkOption { type = str; default = cfg.types.fg; };
      border    = mkOption { type = str; default = cfg.types.bg; };
      error     = mkOption { type = str; default = cfg.red; };
      warning   = mkOption { type = str; default = cfg.yellow; };
      highlight = mkOption { type = str; default = cfg.white; };
    };
  };
}
