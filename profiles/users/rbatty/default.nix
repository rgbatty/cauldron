{ config, ... }:
let
in {
  imports = [ ../common.nix ];

  home = {
    username = "rbatty";
    homeDirectory = "/home/rbatty";
  };
}
