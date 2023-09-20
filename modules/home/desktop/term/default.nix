{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ./iterm.nix
    ./winterm.nix
    ./wezterm
  ];

  home.packages = with pkgs; [
    #kitty
  ];
}
