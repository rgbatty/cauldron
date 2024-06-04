{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./editors/vscode
    ./shells
    ./terminals/wezterm
    ./lanmouse.nix
  ];

  home = {
    username = "riizu";
    homeDirectory = "/home/riizu";
    packages = with pkgs; [
      btop
      # fd
      just
      mangohud
      neovim
      nixpkgs-fmt
    ];
    stateVersion = "23.11";

    # TODO: https://github.com/nix-community/home-manager/issues/1341
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
    # };
  };

  programs.home-manager.enable = true;
}
