{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.desktop.term.wezterm;
  shellCfg = config.modules.home.shell.shells;
in {
  options.modules.home.desktop.term.wezterm = {
    enable = mkEnableOption "wezterm";
  };

  config = mkIf (cfg.enable && pkgs.stdenv.isDarwin) {
    # home.packages = with pkgs; [
    #   # wezterm
    # ];
    
    programs.wezterm = {
      enable = true;

      # enableBashIntegration = shellCfg.bash.enable;
      # enableZshIntegration = shellCfg.bash.enable;

      extraConfig = ''
        local w = require('wezterm')
        local config = w.config_builder()

        config.front_end = 'WebGpu'
        config.webgpu_power_preference = 'HighPerformance'

        -- Styling
        config.color_scheme = 'dracula'
        config.font = w.font('FiraCode Nerd Font')
        config.font_size = 14
        config.window_padding = {
          top = 0,
          bottom = 0,
          left = 0,
          right = 0,
        }
        config.inactive_pane_hsb = {
          saturation = 0.7,
          brightness = 0.6,
        }
        config.window_background_opacity = 0.6
        config.text_background_opacity = 0.4
        config.window_decorations = "RESIZE"

        -- Tabs
        config.use_fancy_tab_bar = false
        config.tab_bar_at_bottom = true
        config.hide_tab_bar_if_only_one_tab = true

        -- Behavior
        config.window_close_confirmation = "NeverPrompt"
        config.mouse_wheel_scrolls_tabs = false
        config.pane_focus_follows_mouse = true
        -- config.native_macos_fullscreen_mode = true
        config.show_update_window = false
        config.check_for_updates = false
        config.audible_bell = "Disabled"
        config.scrollback_lines = 10000
        

        return config
      '';

      colorSchemes = {
        dracula = {
          ansi = [
              "#21222c"
              "#ff5555"
              "#50fa7b"
              "#f1fa8c"
              "#bd93f9"
              "#ff79c6"
              "#8be9fd"
              "#f8f8f2"
          ];
          background = "#282a36";
          brights = [
              "#6272a4"
              "#ff6e6e"
              "#69ff94"
              "#ffffa5"
              "#d6acff"
              "#ff92df"
              "#a4ffff"
              "#ffffff"
          ];
          compose_cursor = "#ffb86c";
          cursor_bg = "#f8f8f2";
          cursor_border = "#f8f8f2";
          cursor_fg = "#282a36";
          foreground = "#f8f8f2";
          scrollbar_thumb = "#44475a";
          selection_bg = "rgba(26.666668% 27.843138% 35.294117% 50%)";
          selection_fg = "rgba(0% 0% 0% 0%)";
          split = "#6272a4";

          tab_bar = {
            background = "#282a36";

            active_tab = {
              bg_color = "#bd93f9";
              fg_color = "#282a36";
              intensity = "Normal";
              italic = true;
              strikethrough = false;
              underline = "None";
            };

            inactive_tab = {
              bg_color = "#282a36";
              fg_color = "#f8f8f2";
              intensity = "Normal";
              italic = false;
              strikethrough = false;
              underline = "None";
            };

            inactive_tab_hover = {
              bg_color = "#6272a4";
              fg_color = "#f8f8f2";
              intensity = "Normal";
              italic = true;
              strikethrough = false;
              underline = "None";
            };

            new_tab = {
              bg_color = "#282a36";
              fg_color = "#f8f8f2";
              intensity = "Normal";
              italic = false;
              strikethrough = false;
              underline = "None";
            };

            new_tab_hover = {
              bg_color = "#ff79c6";
              fg_color = "#f8f8f2";
              intensity = "Normal";
              italic = true;
              strikethrough = false;
              underline = "None";
            };
          };
        };
      };
    };
  };
}
