{ inputs, config, lib, pkgs, ... }: {
  environment.interactiveShellInit = ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
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
      "wez/wezterm"
    ];

    brews = [
    ];


    casks = [
      "discord"
      "docker"
      "firefox"
      "google-chrome"
      "obsidian"
      "wez/wezterm/wezterm"
      "vivaldi"
    ];

    masApps = {

    };
  };
}
