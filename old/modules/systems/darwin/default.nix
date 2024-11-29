inputs: {
  apps = import ./apps inputs;
  fonts = import ./fonts.nix inputs;
  preferences = import ./preferences.nix inputs;
  services = import ./services inputs;

  defaults = {config, lib, pkgs, ...} : {
    environment.shells = with pkgs; [
      bashInteractive
      fish
      zsh
    ];

    nix = {
      settings.trusted-users = [ "root" "@admin" "@staff" "@wheel" ];
      extraOptions = ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';
    };

    nixpkgs.config.allowUnfree = true;


    # enables nix-darwin in shell
    programs.bash.enable = true;
    programs.fish.enable = true;
    programs.zsh.enable = true;

    # Needed to address bug where $PATH is not properly set for fish:
    # https://github.com/LnL7/nix-darwin/issues/122
    programs.fish.loginShellInit =
    let
      # This naive quoting is good enough in this case. There shouldn't be any
      # double quotes in the input string, and it needs to be double quoted in case
      # it contains a space (which is unlikely!)
      dquote = str: "\"" + str + "\"";

      makeBinPathList = map (path: path + "/bin");
    in ''
      fish_add_path --move --prepend --path ${lib.concatMapStringsSep " " dquote (makeBinPathList config.environment.profiles)}
      set fish_user_paths $fish_user_paths
    '';

    services.nix-daemon.enable = true;

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

    system.stateVersion = 4;
  };
}
