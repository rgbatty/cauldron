{ inputs, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.services.yabai;
  jq = "${pkgs.jq}/bin/jq";
in {
  options.modules.home.services.yabai = with types; {
    enable = mkEnableOption "yabai";
  };

  config = mkIf (cfg.enable && pkgs.stdenv.isDarwin) {
    home.file.yabai = {
      executable = true;
      target = ".config/yabai/yabairc";
      text = ''
        sudo yabai --load-sa
        yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

        # Layout (bsp or float)
        yabai -m config layout bsp

        # Tile right(V) + bottom(H)
        yabai -m config window_placement second_child

        # Padding
        yabai -m config top_padding 10
        yabai -m config bottom_padding 10
        yabai -m config left_padding 10
        yabai -m config right_padding 10
        yabai -m config window_gap 10

        # Floating windows on top
        yabai -m config window_topmost on

        # Auto-raise moused windows
        # yabai -m config focus_follows_mouse autoraise

        # Shadows
        yabai -m config window_shadow on

        # Borders
        yabai -m config window_border on
        yabai -m config window_border_width 4
        # yabai -m config active_window_border_color 0x000000
        # yabai -m config insert_window_border_color 0x000000
        # yabai -m config normal_window_border_color 0x000000

        # Opacity
        yabai -m config window_opacity on
        yabai -m config active_window_opacity 1.0
        yabai -m config normal_window_opacity 0.90

        # Rules
        # Forced tiling
        yabai -m rule --add app="Emacs" manage=on

        # Floatable apps

        # System
        yabai -m rule --add app="System Preferences" manage=off
        yabai -m rule --add title="(Copy|Bin|About This Mac|Info)" manage=off
        yabai -m rule --add app="Mail" manage=off
        yabai -m rule --add app="Calculator" manage=off
        yabai -m rule --add app="Calendar" manage=off
        yabai -m rule --add app="Installer" manage=off
        yabai -m rule --add app="Preview" manage=off

        # Apps
        yabai -m rule --add app="Finder" manage=off
        yabai -m rule --add app="Slack" manage=off
        yabai -m rule --add app="Discord" manage=off
        yabai -m rule --add app="Docker Desktop" manage=off

        # Space Assignments
        yabai -m rule --add app="Code" space=1
        yabai -m rule --add app="Vivaldi" space=2
        yabai -m rule --add app="Discord" space=3


        echo "yabai configuration loaded!"
      '';
    };
  };

}

