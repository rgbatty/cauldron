{ inputs, config, lib, pkgs, ... }: {
  services = {
    yabai = {
      enable = true;
      package = pkgs.yabai;
      config = {
        layout = "bsp";
        focus_follows_mouse = "autofocus";
        # window_topmost = "off";

        # external_bar all:${result "${sketchybar} --query bar | ${pkgs.jq}/bin/jq '.geometry.height'"}:0

        top_padding = 20;
        bottom_padding = 20;
        left_padding = 20;
        right_padding = 20;
        window_gap = 20;

        window_border = "on";
        # active_window_border_color ${focusedWindowBorderColor}

        window_opacity = "on";
        active_window_opacity = 1.0;
        normal_window_opacity = 0.9;
      };
      extraConfig = ''
        # yabai -m rule --add app='^Emacs$' manage=on
        # yabai -m rule --add title='Preferences' manage=off layer=above
        # yabai -m rule --add title='^(Opening)' manage=off layer=above
        # yabai -m rule --add title='Library' manage=off layer=above
        # yabai -m rule --add app='^System Preferences$' manage=off layer=above
        # yabai -m rule --add app='Activity Monitor' manage=off layer=above
        # yabai -m rule --add app='Finder' manage=off layer=above
        # yabai -m rule --add app='^System Information$' manage=off layer=above
      '';
    };

    skhd = {
      enable = true;
      package = pkgs.skhd;
      skhdConfig = ''
      '';
    };
  };

}
