{ config, pkgs, ... }:
let
  hardware = [
    ../../../modules/hardware/qmk
  ];

  shells = [
    ../../../modules/shell/fish
    ../../../modules/shell/zsh
  ];
in
{
  imports = shells;
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "riizu";
  home.homeDirectory = "/home/riizu";

  # imports = core ++ extraShells ++ personal;

  # fonts.fonts = with pkgs; [ powerline-fonts dejavu_fonts ];
    # fonts-firacode
}
