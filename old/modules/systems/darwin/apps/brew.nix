{ inputs, config, lib, pkgs, ... }: 

with lib;
let
  cfg = config.modules.systems.darwin.apps.brew;

in {
  options.modules.systems.darwin.apps.brew = with types; {
    enable = mkEnableOption "homebrew";

    taps = mkOption {
      type = lib.types.listOf lib.types.unspecified;
      default = [];
    };

    brews = mkOption {
      type = lib.types.listOf lib.types.unspecified;
      default = [];
    };

    casks = mkOption {
      type = lib.types.listOf lib.types.unspecified;
      default = [];
    };
  };

  config = mkIf cfg.enable {
    environment.interactiveShellInit = ''
      eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
    '';

    homebrew = {
      enable = true;
      
      onActivation = {
        autoUpdate = false;
        # cleanup = "zap";
      };
      
      global = {
        brewfile = true;
        lockfiles = true;
      };

      taps = cfg.taps;
      brews = cfg.brews;
      casks = cfg.casks;
    };
  };
}
