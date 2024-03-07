{ inputs, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.systems.darwin.services.yabai;
  jq = "${pkgs.jq}/bin/jq";
in {
  options.modules.systems.darwin.services.yabai = with types; {
    enable = mkEnableOption "yabai";
  };

  config = mkIf (cfg.enable && pkgs.stdenv.isDarwin) {
    services.yabai = {
      enable = true;
      package = pkgs.yabai;
      config = {
        layout = "bsp";
        auto_balance = "off";
        split_ratio = "0.50";
        window_border = "on";
        window_border_width = "2";
        window_placement = "second_child";
        focus_follows_mouse = "autoraise";
        mouse_follows_focus = "off";
        top_padding = "10";
        bottom_padding = "10";
        left_padding = "10";
        right_padding = "10";
        window_gap = "10";
      };
      extraConfig = ''
        # Rules
        # Forced tiling
        yabai -m rule --add app="emacs" manage=on

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
        yabai -m rule --add app="Brave Browser" space=2
        yabai -m rule --add app="Discord" space=3
        yabai -m rule --add app="Slack" space=3
      '';
    };

        #     # Floating windows on top
        # yabai -m config window_topmost on


        # # Shadows
        # yabai -m config window_shadow on

        # # Borders
        # yabai -m config window_border on
        # yabai -m config window_border_width 4
        # # yabai -m config active_window_border_color 0x000000
        # # yabai -m config insert_window_border_color 0x000000
        # # yabai -m config normal_window_border_color 0x000000

        # # Opacity
        # yabai -m config window_opacity on
        # yabai -m config active_window_opacity 1.0
        # yabai -m config normal_window_opacity 0.90
  };
}
