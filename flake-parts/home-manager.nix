{ inputs, self, withSystem, ... }:
let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;

  mkHome = userConfig: { pkgs }:
    homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ../modules
        { home.stateVersion = "22.11"; }
        userConfig
      ];
    };

in {
  flake = {
    homeConfigurations = withSystem "x86_64-linux" (ctx@{ pkgs, system, ... }: {
      # TODO: Replace with a default profile that builds based on current system
      rgbatty = mkHome ../profiles/users/rgbatty { inherit pkgs; };
      riizu = mkHome ../profiles/users/riizu { inherit pkgs; };
    });
  };
}
