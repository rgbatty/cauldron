{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.home.common.lanmouse;
in
{
  imports = [inputs.lan-mouse.homeManagerModules.default];

  options.modules.home.common.lanmouse = {
    enable = lib.mkEnableOption "Enable LanMouse";
  };

  config = lib.mkIf cfg.enable {

    programs.lan-mouse = {
      enable = true;
      # systemd = false;
      # package = inputs.lan-mouse.packages.${pkgs.stdenv.hostPlatform.system}.default
      # Optional configuration in nix syntax, see config.toml for available options
      # settings = { };
    };
  };
}
