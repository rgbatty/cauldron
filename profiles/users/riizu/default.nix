{ config, ... }:
let
in {
  imports = [ ../common.nix ];

  home = {
    username = "riizu";
    homeDirectory = "/home/riizu";
  };
}
