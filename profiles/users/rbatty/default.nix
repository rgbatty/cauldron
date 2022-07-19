{ config, pkgs, homePrefix, ... }:
{
  imports = [ ../common.nix ];

  home = {
    username = "rbatty";
    homeDirectory = "${homePrefix}/rbatty";
  };
}
