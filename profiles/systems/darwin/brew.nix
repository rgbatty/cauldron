{ inputs, config, lib, pkgs, ... }: {
  homebrew = {
    enable = true;
    autoUpdate = false;
    cleanup = "zap";
    global = {
      brewfile = true;
      noLock = true;
    };
    taps = [
      "homebrew/cask"
      "homebrew/cask-versions"
      "homebrew/core"
      "homebrew/services"
      "koekeishiya/formulae"
      # "wez/wezterm"
    ];

    brews = [];


    casks = [
      # "alfred"
      "discord"
      "docker"
      "firefox"
      "google-chrome"
      "obsidian"
      # "raycast"
      # "wez/wezterm/wezterm"
      "vivaldi"
    ];

    masApps = {

    };
  };
}
