{ config, pkgs, lib, inputs, ... }:
let
  cfg = config.modules.home.nixos.hyprland;
  hyprlandFlake = inputs.hyprland.packages.${pkgs.system}.hyprland;
in
{
  options = {
    modules.home.nixos.hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      waybar # Panel
      mako # Notifications

      alsa-utils
      mpd


      libnotify

      # Wallpaper daemons
      # hyprpaper
      # swaybg
      # wpaperd
      # mpvpaper
      swww

      # App launchers
      rofi-wayland
      # wofi
      # anyrun

      wl-clipboard # clipboard

      grimblast
    ];

    # May be redundant?
    # programs.hyprland = {
    #   enable = true;
    # };

    wayland.windowManager.hyprland = {
      enable = true;
      package = hyprlandFlake;
      # xwayland = {
      #   enable = true;
      # };

      # plugins = [];

      settings = {
        "$mod" = "SUPER";

        # animations = {
        #   enabled = 1;
        #   "workspaces,1,8,default"
        # };

        decoration = {
          rounding = 8;

          active_opacity = 1.0;
          inactive_opacity = 0.9;
          fullscreen_opacity = 1.0;

          blur = {
            enabled = true;
            size = 3; # minimum 1
            passes = 1; # minimum 1, more passes = more resource intensive.
            ignore_opacity = false;
          };

          # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
          # if you want heavy blur, you need to up the blur_passes.
          # the more passes, the more you can up the blur_size without noticing artifacts.
        };

        # nvidia settings
        env = [
          # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
          # "LIBVA_DRIVER_NAME,nvidia"
          #"XDG_SESSION_TYPE,wayland"
          #"GBM_BACKEND,nvidia-drm"
          #"__GLX_VENDOR_LIBRARY_NAME,nvidia"
          # fix https://github.com/hyprwm/Hyprland/issues/1520
          "WLR_NO_HARDWARE_CURSORS,1"

          "NIXOS_OZONE_WL,1" # for any ozone-based browser & electron apps to run on wayland

          "MOZ_ENABLE_WAYLAND,1" # for firefox to run on wayland
          "MOZ_WEBRENDER,1"

          # misc
          "_JAVA_AWT_WM_NONREPARENTING,1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_QPA_PLATFORM,wayland"
          "SDL_VIDEODRIVER,wayland"
          "GDK_BACKEND,wayland"
        ];

        exec-once = [
          "waybar &"
          "mako &"
        ];

        monitor = [
          "DP-1,5120x1440@240,0x0,1"
        ];

        misc = {
          vfr = true; #CPU usage improvements?
          vrr = false; # adaptive sync
        };

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 4;
          # col.active_border = "0xFFB4A1DB";
          # col.inactive_border = "0xFF343A40";
        };

        input = {
          follow_mouse = 1;
          kb_layout = "us";
          mouse_refocus = false;
          numlock_by_default = 1;
          repeat_delay = 140;
          repeat_rate = 30;
        };

        xwayland = {
          force_zero_scaling = true;
        };

        bind = [
          "$mod,RETURN,exec,kitty"
          "$mod,SPACE,exec,rofi -show drun -show-icons"
          "$mod,c,exec,wl-copy"
          "$mod,v,exec,wl-paste"

          "$mod,Q,killactive,"
          "$mod,M,exit,"
          "$mod,S,togglefloating,"
          "$mod,g,togglegroup"
          # "$mod,tab,changegroupactive"
          # "$mod,P,pseudo,"

          # Vim binds
          "$mod,h,movefocus,l"
          "$mod,l,movefocus,r"
          "$mod,k,movefocus,u"
          "$mod,j,movefocus,d"

          "$mod,left,movefocus,l"
          "$mod,down,movefocus,r"
          "$mod,up,movefocus,u"
          "$mod,right,movefocus,d"

          "$mod,1,workspace,1"
          "$mod,2,workspace,2"
          "$mod,3,workspace,3"
          "$mod,4,workspace,4"
          "$mod,5,workspace,5"
          "$mod,6,workspace,6"
          "$mod,7,workspace,7"
          "$mod,8,workspace,8"

          ################################## Move ###########################################
          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, J, movewindow, d"
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"

          #---------------------------------------------------------------#
          # Move active window to a workspace with mainMod + ctrl + [0-9] #
          #---------------------------------------------------------------#
          # "$mod $mainMod CTRL, 1, movetoworkspace, 1"
          # "$mod $mainMod CTRL, 2, movetoworkspace, 2"
          # "$mod $mainMod CTRL, 3, movetoworkspace, 3"
          # "$mod $mainMod CTRL, 4, movetoworkspace, 4"
          # "$mod $mainMod CTRL, 5, movetoworkspace, 5"
          # "$mod $mainMod CTRL, 6, movetoworkspace, 6"
          # "$mod $mainMod CTRL, 7, movetoworkspace, 7"
          # "$mod $mainMod CTRL, 8, movetoworkspace, 8"
          # "$mod $mainMod CTRL, 9, movetoworkspace, 9"
          # "$mod $mainMod CTRL, 0, movetoworkspace, 10"
          # "$mod $mainMod CTRL, left, movetoworkspace, -1"
          # "$mod $mainMod CTRL, right, movetoworkspace, +1"
          # same as above, but doesnt switch to the workspace
          "$mod $mainMod SHIFT, 1, movetoworkspacesilent, 1"
          "$mod $mainMod SHIFT, 2, movetoworkspacesilent, 2"
          "$mod $mainMod SHIFT, 3, movetoworkspacesilent, 3"
          "$mod $mainMod SHIFT, 4, movetoworkspacesilent, 4"
          "$mod $mainMod SHIFT, 5, movetoworkspacesilent, 5"
          "$mod $mainMod SHIFT, 6, movetoworkspacesilent, 6"
          "$mod $mainMod SHIFT, 7, movetoworkspacesilent, 7"
          "$mod $mainMod SHIFT, 8, movetoworkspacesilent, 8"
        ];

        bindm = [
          # Mouse binds
          "SUPER,mouse:272,movewindow"
          "SUPER,mouse:273,resizewindow"
        ];
      };

      # raw text passed to hyprland.conf
      # extraConfig = ''
      # '';
      systemd.enable = true;
    };

    home.file.".wayland-session" = {
      source = "${hyprlandFlake}/bin/Hyprland";
      executable = true;
    };
  };
}
