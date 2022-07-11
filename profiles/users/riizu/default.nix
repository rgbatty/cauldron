{ config, pkgs, ... }:
let
  hardware = [
    ../../../modules/hardware/qmk.nix
  ];

  shells = [
    ../../../modules/shell/fish
    ../../../modules/shell/zsh
  ];
in
{
  imports = shells ++ hardware;

  home.username = "riizu";
  home.homeDirectory = "/home/riizu";

  # fonts.fonts = with pkgs; [ powerline-fonts dejavu_fonts ];
    # fonts-firacode
}
