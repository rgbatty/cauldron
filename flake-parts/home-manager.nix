{ inputs, lib, self, withSystem, ... }:
let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;

  mkHome = system: user: withSystem system (ctx @ { pkgs, ... }:
    let
      inherit (pkgs.stdenv) isDarwin;

      homePath = if isDarwin then "/Users/${user}" else "/home/${user}";
      baseConfig = { home = { username = user; homeDirectory = homePath; }; };

    in homeManagerConfiguration {
      inherit pkgs;
      modules = [ baseConfig ../modules/home ../profiles/users/${user} ];
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
      "rbatty@selene" = mkHomeLinux "rbatty" ;
    };

    packages.aarch64-darwin."rbatty@luna" =
      self.outputs.homeConfigurations.${"rbatty@luna"}.activationPackage;

    packages.x86_64-darwin."rbatty@fang" =
      self.outputs.homeConfigurations.${"rbatty@fang"}.activationPackage;

    packages.x86_64-linux."rbatty@selene" =
      self.outputs.homeConfigurations.${"rbatty@selene"}.activationPackage;
  };
}
