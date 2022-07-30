{ inputs, config, lib, pkgs, ... }: {
  environment.interactiveShellInit = ''
    eval "$\{/opt/homebrew/bin/brew shellenv}"
  '';

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
