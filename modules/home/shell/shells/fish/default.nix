{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.shell.shells.fish;

  shellAbbrs = import ../common/abbrs.nix;
  shellAliases = import ../common/aliases.nix;
in {
  options.modules.shell.shells.fish = with types; {
    enable = mkEnableOption "fish";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fish
      fishPlugins.done
      fishPlugins.forgit
      # TODO: Fzf-fish breaks after channel updates
      # fishPlugins.fzf-fish
      fishPlugins.pisces
    ];

    programs.fish = {
      inherit shellAbbrs shellAliases;

      enable = true;

      plugins = [
        {
          name = "fish-ssh-agent";
          src = pkgs.fetchFromGitHub {
            owner = "danhper";
            repo = "fish-ssh-agent";
            rev = "fd70a2afdd03caf9bf609746bf6b993b9e83be57";
            sha256 = "sha256-e94Sd1GSUAxwLVVo5yR6msq0jZLOn2m+JZJ6mvwQdLs=";
          };
        }

        {
          name = "fish-dracula";
          src = pkgs.fetchFromGitHub {
            owner = "dracula";
            repo = "fish";
            rev = "62b109f12faab5604f341e8b83460881f94b1550";
            sha256 = "sha256-0TlKq2ur2I6Bv7pu7JObrJxV0NbQhydmCuUs6ZdDU1I=";
          };
        }
      ];

      interactiveShellInit = ''
        set -g fish_greeting ""
      '';
    };
  };
}
