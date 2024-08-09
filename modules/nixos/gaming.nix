{ config, lib, pkgs, pkgs-xivlauncher, ... }:
let
  cfg = config.modules.nixos.gaming;
in
{
  options.modules.nixos.gaming = {
    enable = lib.mkEnableOption "Enable Gaming";
  };

  config = lib.mkIf cfg.enable {
    users.users.riizu.packages = [
      pkgs.lutris
      pkgs.steam
      # retroarchFull
      pkgs.wine
      pkgs-xivlauncher.xivlauncher
    ];

    programs.steam.enable = true;
  };
}
