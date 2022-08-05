# TODO: Browser Configuration
# * Add Vivaldi pkg and configuration
# * Add Firefox pkg and configuration
# * Add default browser support

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

  # config = mkIf (cfg.default != null) {
  #   env.BROWSER = cfg.default;
  # };
}
