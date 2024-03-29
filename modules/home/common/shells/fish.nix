{ config, pkgs, lib, ... }:
let
  cfg = config.modules.home.common.shells.fish;
  # editorCfg = config.modules.home.common.editors;

  shellAliases = import ./aliases.nix;
in
{
  options = {
    modules.home.common.shells.fish.enable = lib.mkEnableOption "Enable Fish";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      fishPlugins.done
      fishPlugins.pisces
    ];

    programs.fish = {
      inherit shellAliases;

      enable = true;

      interactiveShellInit = lib.mkMerge [
        ''
          set -g fish_greeting ""
          ${pkgs.zoxide}/bin/zoxide init fish | source
        ''

        # (lib.mkIf (editorCfg.emacs.enable && editorCfg.emacs.doom.enable) ''
        #   set -g --append PATH ${config.xdg.configHome}/emacs/bin
        # '')

        # ''
        #   source $HOME/.asdf/asdf.fish
        # ''
      ];

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
    };
  };




}

