{ inputs, lib, config, flake, pkgs, home-manager, ... }: {
  imports = [  ];

  nix = {
    package = pkgs.nixFlakes;
    trustedUsers = [ "@admin" "@staff" ];
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
      keep-derivations = true
      keep-outputs = true
    '';
  };

  services.nix-daemon.enable = true;

  environment.shells = with pkgs; [ bashInteractive fish zsh ];

  # Needed to address bug where $PATH is not properly set for fish:
  # https://github.com/LnL7/nix-darwin/issues/122
  programs.fish.shellInit = ''
    for p in (string split : ${config.environment.systemPath})
      if not contains $p $fish_user_paths
        set -g fish_user_paths $fish_user_paths $p
      end
    end
  '';
  environment.variables.SHELL = "${pkgs.fish}/bin/fish";

  # enables nix-darwin in shell
  programs.bash.enable = true;
  programs.fish.enable = true;
  programs.zsh.enable = true;

  system.stateVersion = 4;

  # TODO: Remove once https://github.com/LnL7/nix-darwin/issues/139 and https://github.com/LnL7/nix-darwin/issues/214 are resolved
  system.activationScripts.applications.text = ''
    # Set up applications.
    echo "setting up /Applications/Nix Apps..." >&2
    # Clean up for links created at the old location in HOME
    if [ -L ~/Applications
          -a $(readlink ~/Applications | grep --quiet
                '/nix/store/.*-system-applications/Applications')
        ]
      rm ~/Applications
    elif [ -L '~/Applications/Nix Apps'
            -a $(readlink '~/Applications/Nix Apps' | grep --quiet
                  '/nix/store/.*-system-applications/Applications')
          ]
      rm '~/Applications/Nix Apps'
    fi
    if [ ! -e '/Applications/Nix Apps' -o -L '/Applications/Nix Apps' ]; then
      ln -sfn ${cfg.build.applications}/Applications '/Applications/Nix Apps'
    else
      echo "warning: /Applications/Nix Apps is not owned by nix-darwin, skipping App linking..." >&2
    fi
  '';
}
