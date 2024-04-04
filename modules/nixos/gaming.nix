{ config, lib, pkgs, ... }:
let
  cfg = config.modules.nixos.gaming;
in
{
  options.modules.nixos.gaming = {
    enable = lib.mkEnableOption "Enable Gaming";
  };

  config = lib.mkIf cfg.enable {
    users.users.riizu.packages = with pkgs; [
      lutris
      steam
      retroarchFull
      wine
      xivlauncher
    ];

    programs.steam.enable = true;
  };
}
