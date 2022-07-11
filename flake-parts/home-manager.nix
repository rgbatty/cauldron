{ inputs, self, withSystem, ... }:
let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;

  mkHome = userConfig: { pkgs }:
    homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ../modules/core
        userConfig
      ];
    };

in {
  flake = {
    homeConfigurations = withSystem "x86_64-linux" (ctx@{ pkgs, system, ... }: {
      rgbatty = mkHome ../profiles/users/rgbatty { inherit pkgs; };
      riizu = mkHome ../profiles/users/riizu { inherit pkgs; };
    });

    # packages = let
    #   mapHomeConfigs = configName: homeConfig:
    #     lib.attrsets.nameValuePair "home-${configName}"
    #     homeConfig.activationPackage;
    #   mapSystems = _system: homeConfigs:
    #     lib.attrsets.mapAttrs' (lib.debug.traceVal homeConfigs);
    # in lib.debug.traceValSeq (builtins.mapAttrs mapSystems homeConfigurations);
    #
    # packages.aarch64-darwin.home-lodurr =
    #   self.outputs.homeConfigurations.aarch64-darwin.lodurr.activationPackage;
    # packages.x86_64-darwin.home-kvasir =
    #   self.outputs.homeConfigurations.x86_64-darwin.kvasir.activationPackage;
    # packages.x86_64-linux = with self.outputs.homeConfigurations.x86_64-linux; {
    #   home-heimdall = heimdall.activationPackage;
    #   home-yggdrasil = yggdrasil.activationPackage;
    # };
  };
}
