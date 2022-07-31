{ inputs, config, lib, pkgs, ... }:

let
  result = cmd: "$(${cmd})";
  focusedWindowBorderColor = "";
in {
  environment.systemPackages = with pkgs; [
    # yabai
    # skhd
  ];

  services = {
    yabai = {
      # enable = true;
      package = pkgs.yabai;
      enableScriptingAddition = true;
      config = {
        layout = "bsp";
        focus_follows_mouse = "autofocus";
        window_topmost = "off";

        # external_bar = "all:${result "${pkgs.sketchybar} --query bar | ${pkgs.jq}/bin/jq '.geometry.height'"}:0";

        top_padding = 20;
        bottom_padding = 20;
        left_padding = 20;
        right_padding = 20;
        window_gap = 20;

        window_border = "on";
        active_window_border_color = focusedWindowBorderColor;

        window_opacity = "on";
        active_window_opacity = 1.0;
        normal_window_opacity = 0.9;
      };
      extraConfig = ''
        yabai -m rule --add app='^Emacs$' manage=on
        yabai -m rule --add title='Preferences' manage=off layer=above
        yabai -m rule --add title='^(Opening)' manage=off layer=above
        # yabai -m rule --add title='Library' manage=off layer=above
        yabai -m rule --add app='^System Preferences$' manage=off layer=above
        yabai -m rule --add app='Activity Monitor' manage=off layer=above
        # yabai -m rule --add app='Finder' manage=off layer=above
        yabai -m rule --add app='^System Information$' manage=off layer=above

        # yabai -m rule --add app="^(Slack|Discord)$" space=^1
        yabai -m rule --add app="^(Code|Emacs)$" space=^2
        # yabai -m rule --add app="Vivaldi" space=^3
        # yabai -m rule --add app="Spotify" space=^4
      '';
    };

    skhd = {
      # enable = true;
      package = pkgs.skhd;
      skhdConfig = ''
        # Open Terminal
        alt - return : /Applications/Alacritty.App/Contents/MacOS/alacritty
        # Toggle Window
        lalt - t : yabai -m window --toggle float && yabai -m window --grid 4:4:1:1:2:2
        lalt - f : yabai -m window --toggle zoom-fullscreen
        lalt - q : yabai -m window --close
        # Focus Window
        lalt - up : yabai -m window --focus north
        lalt - down : yabai -m window --focus south
        lalt - left : yabai -m window --focus west
        lalt - right : yabai -m window --focus east
        # Swap Window
        shift + lalt - up : yabai -m window --swap north
        shift + lalt - down : yabai -m window --swap south
        shift + lalt - left : yabai -m window --swap west
        shift + lalt - right : yabai -m window --swap east
        # Resize Window
        shift + cmd - left : yabai -m window --resize left:-50:0 && yabai -m window --resize right:-50:0
        shift + cmd - right : yabai -m window --resize left:50:0 && yabai -m window --resize right:50:0
        shift + cmd - up : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0
        shift + cmd - down : yabai -m window --resize up:-50:0 && yabai -m window --resize down:-50:0
        # Focus Space
        ctrl - 1 : yabai -m space --focus 1
        ctrl - 2 : yabai -m space --focus 2
        ctrl - 3 : yabai -m space --focus 3
        ctrl - 4 : yabai -m space --focus 4
        ctrl - 5 : yabai -m space --focus 5
        #ctrl - left : yabai -m space --focus prev
        #ctrl - right: yabai -m space --focus next
        # Send to Space
        shift + ctrl - 1 : yabai -m window --space 1
        shift + ctrl - 2 : yabai -m window --space 2
        shift + ctrl - 3 : yabai -m window --space 3
        shift + ctrl - 4 : yabai -m window --space 4
        shift + ctrl - 5 : yabai -m window --space 5
        shift + ctrl - left : yabai -m window --space prev && yabai -m space --focus prev
        shift + ctrl - right : yabai -m window --space next && yabai -m space --focus next
        # Menu
        #cmd + space : for now its using the default keybinding to open Spotlight Search
      '';
    };
  };

}

