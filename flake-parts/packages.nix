_inputs:

{
  perSystem = { config, pkgs, ... }:
    let
      callRustPackage = path:
        pkgs.callPackage path { inherit (pkgs.rustPlatform) buildRustPackage; };
    in {
      packages = {
        # localPackages = pkgs.linkFarmFromDrvs "localPackages"
        #   (with config.packages; [ emacs ]);

        nix-wrapper = pkgs.writeShellScriptBin "nix" ''
          ${pkgs.nix}/bin/nix --option experimental-features "nix-command flakes" "$@"
        '';
      };
    };
}
