# TODO: SSH Configuration
# * 'useKeychain' doesn't work in ubuntu

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.services.ssh;
in {
  options.modules.home.services.ssh = with types; {
    enable = mkEnableOption "ssh";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;

      matchBlocks = {
        "*" = {
          extraOptions = {
            controlMaster = "auto";
            controlPath = "~/.ssh/controlmasters/%r@%h:%p";
            controlPersist = "5";

            addKeysToAgent = "yes";
            # useKeychain = "yes";

            serverAliveCountMax = "6";
            serverAliveInterval = "300";
          };
        };
      };
    };
  };

}
