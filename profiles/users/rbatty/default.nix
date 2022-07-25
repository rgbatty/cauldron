{ config, pkgs, ... }:
{
  modules = {
    desktop = {
      apps = {
        unity3d.enable = true;
      };

      browsers = {
        vivaldi.enable = true;
      };

      gaming = {
        steam.enable = true;
      };

      media = {
        documents = {
          enable = true;
          calibre.enable = true;
        };
        recording = {
          enable = true;
          audio.enable = true;
          video.enable = true;
        };
        spotify.enable = true;
      };

      term = {
        iterm.enable = true;
      };
    };

    dev = {
      elixir.enable = true;
      go.enable = true;
      node.enable = true;
      python.enable = true;
      ruby.enable = true;
      rust.enable = true;
    };

    editors = {
      emacs = {
        enable = true;
        doom.enable = true;
      };
      vim.enable = true;
      vscode.enable = true;
    };

    hardware = {
      qmk.enable = true;
      zmk.enable = true;
    };

    git.enable = true;

    services = {
      ssh.enable = true;
      docker.enable = true;
      vaultwarden.enable = true;
    };

    shell = {
      shells = {
        bash.enable = true;
        fish.enable = true;
        zsh.enable = true;
      };

      starship.enable = true;

      utilities = {
        enable = true;
        modern = true;
        navi = true;
      };
    };
  };
}
