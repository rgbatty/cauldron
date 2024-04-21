{ inputs, lib, pkgs, ... }:

{
  imports = [
    ../common
    ./hyprland
  ];

  modules.home = {
    common = {
      editors = {
        vscode.enable = true;
      };

      shells = {
        bash.enable = true;
        fish.enable = true;
        zsh.enable = true;
      };

      terminals = {
        wezterm.enable = true;
      };
    };

    nixos = {
      hyprland.enable = true;
    };
  };

  home.packages = with pkgs; [
    discord
    # firefox
    unetbootin
    # vivaldi
  ];
}
