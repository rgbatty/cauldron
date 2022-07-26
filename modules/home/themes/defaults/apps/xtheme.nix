{ options, config, lib, pkgs, ... }:

with lib;
let
  themeCfg = config.modules.home.theme;
  cfg = themeCfg.xtheme;
in {
  options.modules.home.theme.xtheme = with types; {
    enable = mkEnableOption;
  };

  config = mkIf cfg.enable (mkMerge [
    # (let xrdb = ''cat "$XDG_CONFIG_HOME"/xtheme/* | ${pkgs.xorg.xrdb}/bin/xrdb -load'';
    #   in {
    #     home.configFile."xtheme.init" = {
    #       text = xrdb;
    #       executable = true;
    #     };
    #     modules.theme.onReload.xtheme = xrdb;
    #   })
    # {
    #   home.configFile = {
    #     "xtheme/00-init".text = with themeCfg.colors; ''
    #       #define bg   ${types.bg}
    #       #define fg   ${types.fg}
    #       #define blk  ${black}
    #       #define red  ${red}
    #       #define grn  ${green}
    #       #define ylw  ${yellow}
    #       #define blu  ${blue}
    #       #define mag  ${magenta}
    #       #define cyn  ${cyan}
    #       #define wht  ${white}
    #       #define bblk ${grey}
    #       #define bred ${brightred}
    #       #define bgrn ${brightgreen}
    #       #define bylw ${brightyellow}
    #       #define bblu ${brightblue}
    #       #define bmag ${brightmagenta}
    #       #define bcyn ${brightcyan}
    #       #define bwht ${silver}
    #     '';
    #     "xtheme/05-colors".text = ''
    #       *.foreground: fg
    #       *.background: bg
    #       *.color0:  blk
    #       *.color1:  red
    #       *.color2:  grn
    #       *.color3:  ylw
    #       *.color4:  blu
    #       *.color5:  mag
    #       *.color6:  cyn
    #       *.color7:  wht
    #       *.color8:  bblk
    #       *.color9:  bred
    #       *.color10: bgrn
    #       *.color11: bylw
    #       *.color12: bblu
    #       *.color13: bmag
    #       *.color14: bcyn
    #       *.color15: bwht
    #     '';
    #     "xtheme/05-fonts".text = with themeCfg.fonts.mono; ''
    #       *.font: xft:${name}:pixelsize=${toString(size)}
    #       Emacs.font: ${name}:pixelsize=${toString(size)}
    #     '';
    #   };
    # }
  ]);
}
