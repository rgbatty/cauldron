{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.home.desktop.browsers;
in {
  imports = [
    ./firefox.nix
    ./vivaldi.nix
  ];

  options.modules.home.desktop.browsers = {
    default = mkOption {
      description = "Default Browser";
      type = (with types; nullOr str);
      default = null;
    };
  };
}
