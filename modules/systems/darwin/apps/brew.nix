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
      # TODO: Pick a launcher for macos
      # "alfred"
      "discord"
      "docker"
      "firefox"
      "google-chrome"
      "obsidian"
      # "raycast"
      "wez/wezterm/wezterm"
      "vivaldi"
    ];

    masApps = {

    };

    # extraConfig = ''
    #   brew "yabai", restart_service: true
    #   brew "skhd", restart_service: true
    # '';
  };
}
