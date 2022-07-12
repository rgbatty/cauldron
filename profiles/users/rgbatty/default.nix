{ config, ... }:
let
in {
  imports = [ ../common.nix ];

  home = {
    username = "rgbatty";
    homeDirectory = "/home/rgbatty";
  };
}
