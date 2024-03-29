{ config, pkgs, lib, ... }:
let
  cfg = config.modules.nixos.x11;
in
{
  options.modules.nixos.x11 = {
    enable = lib.mkEnableOption "Enable X11";
  };

  config = lib.mkIf cfg.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    # Enable the KDE Plasma Desktop Environment.
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;
    services.xserver = {
      layout = "us";
      xkbVariant = "";
      xkb = {
        layout= "us";
        variant = "";
      };
      videoDrivers = [ "nvidia" ];
    };
  };
}
