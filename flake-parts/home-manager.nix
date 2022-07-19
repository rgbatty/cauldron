{ inputs, lib, self, withSystem, ... }:
let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;

  mkHome = system: user: withSystem system (ctx @ { pkgs, ... }:
    let
      homePrefix = if pkgs.stdenv.isDarwin then "/Users" else "/home";
      baseConfig = { home = { username = user; homeDirectory = "${homePrefix}/${user}"; }; };
      userModules = [ ../modules ../profiles/users/${user} ];

    in homeManagerConfiguration {
      inherit pkgs;
      modules = [ baseConfig ] ++ userModules;
      extraSpecialArgs = { flake = self; };
    });

  mkHomeAppleSilicon = name: mkHome "aarch64-darwin" name;
  mkHomeAppleIntel = name: mkHome "x86_64-darwin" name;
  mkHomeLinux = name: mkHome "x86_64-linux" name;
in {
  flake = {
    homeConfigurations = {
        "rbatty@luna" = mkHomeAppleSilicon "rbatty" ;
        "rbatty@fang" = mkHomeAppleIntel "rbatty" ;
        "riizu@koumori" = mkHomeLinux "riizu" ;
    };

    packages.aarch64-darwin."rbatty@luna" =
      self.outputs.homeConfigurations.${"rbatty@luna"}.activationPackage;

    packages.x86_64-darwin."rbatty@fang" =
      self.outputs.homeConfigurations.${"rbatty@fang"}.activationPackage;

    packages.x86_64-linux."riizu@koumori" =
      self.outputs.homeConfigurations.${"riizu@koumori"}.activationPackage;
  };
}
