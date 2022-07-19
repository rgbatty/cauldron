{ inputs, config, lib, pkgs, ... }:
let
  commonModules = [
    # Core
    ./git
    ./home.nix
    ./packages.nix

    # Desktop
    # # apps
    ./desktop/apps/unity3d.nix
    # # browsers
    ./desktop/browsers/firefox.nix
    ./desktop/browsers/vivaldi.nix
    # # gaming
    ./desktop/gaming/steam.nix
    # # media
    ./desktop/media/recording.nix
    ./desktop/media/spotify.nix
    # # term
    ./desktop/term/iterm.nix
    ./desktop/term/winterm.nix

    # Dev
    ./dev/elixir.nix
    ./dev/go.nix
    ./dev/node.nix
    ./dev/python.nix
    ./dev/ruby.nix
    ./dev/rust.nix

    # Editors
    ./editors/emacs.nix
    ./editors/vim.nix
    ./editors/vscode.nix

    # Hardware
    ./hardware/qmk.nix
    ./hardware/zmk.nix

    # Services
    ./services/docker.nix
    ./services/ssh.nix
    ./services/vaultwarden.nix

    # Shell
    ./shell/bash
    ./shell/fish
    ./shell/zsh
    ./shell/utilities.nix
    ./shell/starship.nix

    # Themes
    ./themes
  ];


in {
  # TODO: Find a way to auto-import the whole modules directory
  imports = commonModules;

  home.packages = with pkgs; [
    manix
    nix-index
  ];
}
