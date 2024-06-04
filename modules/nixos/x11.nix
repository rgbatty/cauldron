{ config, pkgs, lib, ... }:
let
  cfg = config.modules.nixos.x11;
  nvidiaCfg = config.modules.nixos.nvidia;
in
{
  options.modules.nixos.x11 = {
    enable = lib.mkEnableOption "Enable X11";
  };

  config = lib.mkIf cfg.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
    services.xserver = {
      xkb = {
        layout= "us";
        variant = "";
      };
    };
  };
}
