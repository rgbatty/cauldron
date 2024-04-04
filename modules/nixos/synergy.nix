{ config, lib, pkgs, ... }:
let
  cfg = config.modules.nixos.synergy;
  waylandCfg = config.modules.nixos.wayland;
  synergyPkg = if waylandCfg.enable then pkgs.waynergy else pkgs.synergy;
in
{
  options.modules.nixos.synergy = {
    enable = lib.mkEnableOption "Enable Synergy";
  };

  config = lib.mkIf cfg.enable {
    users.users.riizu.packages = with pkgs; [
      synergyPkg
    ];
  };
}
