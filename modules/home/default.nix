inputs: { config, lib, pkgs, ... }:

with lib; let
  systemPackages = lib.optionals (pkgs.stdenv.isLinux) [ pkgs.xdg_utils ];
in {
  imports = [
    ./desktop
    ./dev
    ./editors
    ./hardware
    ./nix
    ./services
    ./shell
    ./themes
  ];

  config = {
    # Remove once merged - https://github.com/nix-community/home-manager/issues/2942
    nixpkgs.config.allowUnfreePredicate = (pkg: true);

    home = {
      packages = systemPackages ++ [pkgs.home-manager];
      stateVersion = "22.11";

      # TODO: Still needed?
      # activation = mkIf pkgs.stdenv.isDarwin {
      #   copyApplications = let
      #     apps = pkgs.buildEnv {
      #       name = "home-manager-applications";
      #       paths = config.home.packages;
      #       pathsToLink = "/Applications";
      #     };
      #   in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      #     baseDir="$HOME/Applications/Home Manager Apps"
      #     if [ -d "$baseDir" ]; then
      #       rm -rf "$baseDir"
      #     fi
      #     mkdir -p "$baseDir"
      #     for appFile in ${apps}/Applications/*; do
      #       target="$baseDir/$(basename "$appFile")"
      #       $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
      #       $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
      #     done
      #   '';
      #   };
    };

    manual.manpages.enable = true;

    programs.home-manager.enable = true;
  };
}

