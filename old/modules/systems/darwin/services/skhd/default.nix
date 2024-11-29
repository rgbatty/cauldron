{ inputs, config, lib, pkgs, osConfig, ... }:

with lib;
let
  cfg = config.modules.systems.darwin.services.skhd;
  jq = "${pkgs.jq}/bin/jq";

  MODKEY = "alt";

  wm = {
    core = {
      terminal = "${MODKEY} - return";
      cmdBar = "${MODKEY} - space";
      rotateLayout = "${MODKEY} - ";
      closeWindow = "${MODKEY} - c";
      restart = "${MODKEY} + shift - r";
      stop = "${MODKEY} - ";
    };

    focus = {
      up = "${MODKEY} - up";
      down = "${MODKEY} - down";
      left = "${MODKEY} - left";
      right = "${MODKEY} - right";
    };

    rotate = {
      cw = "${MODKEY} + shift - right";
      ccw = "${MODKEY} + shift - left";
    };

    size = {
      expand = "${MODKEY} - h";
      shrink = "${MODKEY} - l";
    };

    spaces = {
      focus1 = "${MODKEY} - 1";
      focus2 = "${MODKEY} - 2";
      focus3 = "${MODKEY} - 3";
      focus4 = "${MODKEY} - 4";
      focus5 = "${MODKEY} - 5";

      send1 = "${MODKEY} + shift - 1";
      send2 = "${MODKEY} + shift - 2";
      send3 = "${MODKEY} + shift - 3";
      send4 = "${MODKEY} + shift - 4";
      send5 = "${MODKEY} + shift - 5";
    };
  };
in {
  options.modules.systems.darwin.services.skhd = with types; {
    enable = mkEnableOption "skhd";
  };

  config = with wm; mkIf (cfg.enable && pkgs.stdenv.isDarwin) {
    services.skhd = {
      enable = true;
      package = pkgs.skhd;
      skhdConfig = ''
        # ======Core Actions================================================================

        ${core.terminal} : wezterm
        # ${core.cmdBar} : Spotlight
        # ${core.rotateLayout} :
        ${core.closeWindow} : yabai -m window --close
        # ${core.restart} :
        # Restart Yabai
        # MODKEY + shift - r:
        # shift + ctrl + alt - r : \
        #     /usr/bin/env osascript <<< \
        #         "display notification \"Restarting Yabai\" with title \"Yabai\""; \
        #     launchctl kickstart -k "gui/$\{UID}/homebrew.mxcl.yabai"
        # ${core.stop} :

        # ======Manipulation================================================================

        ${focus.up} : yabai -m window --focus north
        ${focus.down} : yabai -m window --focus south
        ${focus.left} : yabai -m window --focus west
        ${focus.right} : yabai -m window --focus east

        ${rotate.ccw} : yabai -m space --rotate 270
        ${rotate.cw} : yabai -m space --rotate 90

        ${size.expand} : yabai -m window --resize left:-50:0; yabai -m window --resize right:-50:0
        ${size.shrink} : yabai -m window --resize left:50:0; yabai -m window --resize right:50:0

        # shift + cmd - up : yabai -m window --resize up:-50:0; yabai -m window --resize down:-50:0
        # shift + cmd - down : yabai -m window --resize up:-50:0; yabai -m window --resize down:-50:0

        # Float / Unfloat window
        # alt - t : yabai -m window --toggle float; yabai -m window --toggle border --grid 4:4:1:1:2:2
        # shift + alt - space : yabai -m window --toggle float; yabai -m window --toggle border

        # Toggle Window
        # alt - f : yabai -m window --toggle zoom-fullscreen
        # shift + alt - f : yabai -m window --toggle native-fullscreen

        # Swap windows
        # shift + ctrl - up : yabai -m window --swap north
        # shift + ctrl - down : yabai -m window --swap south
        # shift + ctrl - left : yabai -m window --swap west
        # shift + ctrl - right : yabai -m window --swap east

        # Moving windows
        # shift + alt - up : yabai -m window --warp north
        # shift + alt - down : yabai -m window --warp south
        # shift + alt - left : yabai -m window --warp west
        # shift + alt - right : yabai -m window --warp east

        # Equalize size of windows
        # alt + ctrl - e : yabai -m space --balance

        # ======Spaces & Monitors===========================================================

        # MODKEY + 1-9	switch focus to workspace (1-9)
        ${spaces.focus1} : yabai -m space --focus 1
        ${spaces.focus2} : yabai -m space --focus 2
        ${spaces.focus3} : yabai -m space --focus 3
        ${spaces.focus4} : yabai -m space --focus 4
        ${spaces.focus5} : yabai -m space --focus 5

        # MODKEY - left : yabai -m space --focus prev
        # MODKEY - right: yabai -m space --focus next

        # MODKEY + SHIFT + 1-9	send focused window to workspace (1-9)
        ${spaces.send1} : yabai -m window --space 1
        ${spaces.send2} : yabai -m window --space 2
        ${spaces.send3} : yabai -m window --space 3
        ${spaces.send4} : yabai -m window --space 4
        ${spaces.send5} : yabai -m window --space 5

        # MODKEY + shift - left : yabai -m window --space prev; yabai -m space --focus prev
        # MODKEY + shift - right : yabai -m window --space next; yabai -m space --focus next

        # Move & focus
        # shift + alt - m : yabai -m window --space last; yabai -m space --focus last
        # shift + alt - p : yabai -m window --space prev; yabai -m space --focus prev
        # shift + alt - n : yabai -m window --space next; yabai -m space --focus next

        # MODKEY + w	switch focus to monitor 1
        # MODKEY + e	switch focus to monitor 2
        # MODKEY + r	switch focus to monitor 3
        # MODKEY + period	switch focus to next monitor
        # MODKEY + comma	switch focus to prev monitor
      '';
    };

    system.keyboard.enableKeyMapping = true;
  };
}
