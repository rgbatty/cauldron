{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home;
  browser = [  ];
  associations = {};
in {
  config = {
    home = {
      packages = lib.optionals (pkgs.stdenv.isLinux) [ pkgs.xdg_utils ];
      stateVersion = "22.11";
    };

    manual.manpages.enable = true;

    # TODO: Is this redundant?
    nixpkgs.config.allowUnfree = true;

    programs.home-manager.enable = true;

    xdg = (if pkgs.stdenv.isLinux then {
      mimeApps = {
        enable = true;
        defaultApplications = associations;
        associations.added = associations;
      };
    } else
      {});
  };
}
