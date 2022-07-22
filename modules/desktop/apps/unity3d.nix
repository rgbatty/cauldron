{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.desktop.apps.unity3d;
in {
  options.modules.desktop.apps.unity3d = {
    enable = mkEnableOption "Unity3D";
  };

  config = mkIf cfg.enable {
    # TODO: Unity3D is unmaintained and depends on deprecated pkgs
    # home.packages = with pkgs; [ unity3d ];
  };
}
