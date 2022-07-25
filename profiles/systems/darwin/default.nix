{ inputs, lib, config, flake, pkgs, home-manager, ... }: {
  imports = [ ../. ./preferences.nix ./fonts.nix ./brew.nix ];

  nix = {
    trustedUsers = [ "@admin" "@staff" ];
    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
  };

  services.nix-daemon.enable = true;

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
  system.activationScripts.applications.text = pkgs.lib.mkForce (
    ''
      echo "setting up ~/Applications..." >&2
      rm -rf ~/Applications/Nix\ Apps
      mkdir -p ~/Applications/Nix\ Apps
      for app in $(find ${config.system.build.applications}/Applications -maxdepth 1 -type l); do
        src="$(/usr/bin/stat -f%Y "$app")"
        cp -r "$src" ~/Applications/Nix\ Apps
      done
    ''
  );
}
