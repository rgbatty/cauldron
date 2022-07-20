{ inputs, lib, config, flake, pkgs, home-manager, ... }: {
  imports = [  ];

  services.nix-daemon.enable = true;
  nix.package = pkgs.nixFlakes;
  nix.trustedUsers = [ "@admin" "@staff" ];
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
    keep-derivations = true
    keep-outputs = true
  '';

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
