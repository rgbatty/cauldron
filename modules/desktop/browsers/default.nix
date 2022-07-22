{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.browsers;
in {
  imports = [
    ./firefox.nix
    ./vivaldi.nix
  ];

  options.modules.desktop.browsers = {
    default = mkOption {
      description = "Default Browser";
      type = (with types; nullOr str);
      default = null;
    };
  };

  # config = mkIf (cfg.default != null) {
  #   env.BROWSER = cfg.default;
  # };
}
