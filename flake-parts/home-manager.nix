{ inputs, lib, self, withSystem, ... }:
let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;

  mkHome = user: { pkgs }:
    let
      homePrefix = if pkgs.stdenv.isDarwin then "/Users" else "/home";
      baseConfig = { home = { username = user; homeDirectory = "${homePrefix}/${user}"; }; };
      userModules = [ ../modules ../profiles/users/${user} ];
    in homeManagerConfiguration {
      inherit pkgs;
      modules = [ baseConfig ] ++ userModules;
      extraSpecialArgs = { flake = self; };
    };
in {
  flake = {
    homeConfigurations = {
      aarch64-darwin = withSystem "aarch64-darwin" (ctx@{ pkgs, ... }: {
        luna = mkHome "rbatty" { inherit pkgs; };
      });

      x86_64-darwin = withSystem "x86_64-darwin" (ctx@{ pkgs, ... }: {
        fang = mkHome "rbatty" { inherit pkgs; };
      });

      x86_64-linux = withSystem "x86_64-linux" (ctx@{ pkgs, ... }: {
        koumori = mkHome "riizu" { inherit pkgs; };
      });
    };

    packages.aarch64-darwin = lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "home-${name}"
      value.activationPackage) self.outputs.homeConfigurations.aarch64-darwin;

    packages.x86_64-darwin = lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "home-${name}"
      value.activationPackage) self.outputs.homeConfigurations.x86_64-darwin;

    packages.x86_64-linux = lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "home-${name}"
      value.activationPackage) self.outputs.homeConfigurations.x86_64-linux;
  };
}
