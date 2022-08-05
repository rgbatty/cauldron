{ config, pkgs, ... }:
{
  modules = {
    home = {
      desktop = {
        # apps = {};

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

      services = {
        docker.enable = true;
        ssh.enable = true;
        vaultwarden.enable = true;
        yabai.enable = true;
        skhd.enable = true;
      };

      shell = {
        git.enable = true;

        shells = {
          bash.enable = true;
          fish.enable = true;
          zsh.enable = true;
        };

        starship.enable = true;

        utilities = {
          enable = true;
          modern = true;
        };
      };

      theme.active = "dracula";
    };
  };
}
