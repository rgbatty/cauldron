{ config, inputs, lib, self, ... }: {
  perSystem = { config, pkgs, system, ... }: {
    devShells = let
      basePkgs = [ config.packages.nix-wrapper ];
      NIX_PATH = "nixpkgs=${inputs.nixpkgs}:unstable=${inputs.nixpkgs-unstable}";

  #   shellHook = ''
  #     export FLAKE="$(pwd)"
  #     export PATH="$FLAKE/bin:${nixBin}/bin:$PATH"
  #   '';
    in {
      default = pkgs.mkShell {
        name = "devShell";
        buildInputs = with pkgs; [ just neovim ] ++ basePkgs;

        inherit NIX_PATH;
        # inherit (config.checks.pre-commit-check) shellHook;
      };

      emacs = pkgs.mkShell {
        name = "dotfiles-emacs";
        buildInputs = [ pkgs.emacs ] ++ basePkgs;

        inherit NIX_PATH;
      };
    };
  };
}
