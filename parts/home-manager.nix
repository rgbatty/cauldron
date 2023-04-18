# { inputs, lib, self, withSystem, ... }:
# let
#   inherit (inputs.home-manager.lib) homeManagerConfiguration;

#   mkHome = system: user: withSystem system (ctx @ { pkgs, ... }:
#     let
#       inherit (pkgs.stdenv) isDarwin;

#       homePath = if isDarwin then "/Users/${user}" else "/home/${user}";
#       baseConfig = { home = { username = user; homeDirectory = homePath; }; };

#     in homeManagerConfiguration {
#       inherit pkgs;
#       modules = [ baseConfig ../modules/home ../profiles/users/${user} ];
#       extraSpecialArgs = { flake = self; };
#     });

#   mkHomeAppleSilicon = name: mkHome "aarch64-darwin" name;
#   mkHomeAppleIntel = name: mkHome "x86_64-darwin" name;
#   mkHomeLinux = name: mkHome "x86_64-linux" name;
# in {
#   flake = {
#     homeConfigurations = {
#       "rbatty@luna" = mkHomeAppleSilicon "rbatty" ;
#       "rbatty@fang" = mkHomeAppleIntel "rbatty" ;
#       "rbatty@selene" = mkHomeLinux "rbatty" ;
#     };

#     packages.aarch64-darwin."rbatty@luna" =
#       self.outputs.homeConfigurations.${"rbatty@luna"}.activationPackage;

#     packages.x86_64-darwin."rbatty@fang" =
#       self.outputs.homeConfigurations.${"rbatty@fang"}.activationPackage;

#     packages.x86_64-linux."rbatty@selene" =
#       self.outputs.homeConfigurations.${"rbatty@selene"}.activationPackage;
#   };
# }

{
  self,
  nixpkgs,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.cauldron.homeConfigurations;

  configs = builtins.mapAttrs (_: config: config.finalHome) cfg;

  packages = builtins.attrValues (builtins.mapAttrs (_: config: config.packageModule) cfg);
in {
  options = {
    cauldron.homeConfigurations = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule ({
        name,
        config,
        ...
      }: {
        options = {
          nixpkgs = lib.mkOption {
            type = lib.types.unspecified;
            default = inputs.nixpkgs;
          };

          system = lib.mkOption {type = lib.types.enum ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];};

          username = lib.mkOption {
            type = lib.types.str;
            default = builtins.elemAt (lib.strings.split "@" name) 0;
          };

          hostname = lib.mkOption {
            type = lib.types.str;
            default = builtins.elemAt (lib.strings.split "@" name) 2;
          };

          entryPoint = lib.mkOption {
            type = lib.types.unspecified;
            readOnly = true;
          };

          base = lib.mkOption {
            type = lib.types.str;
            readOnly = true;
          };

          homeDirectory = lib.mkOption {
            type = lib.types.str;
            readOnly = true;
          };

          modules = lib.mkOption {
            type = lib.types.listOf lib.types.unspecified;
            default = [];
          };

          finalModules = lib.mkOption {
            type = lib.types.listOf lib.types.unspecified;
            readOnly = true;
          };

          packageName = lib.mkOption {
            type = lib.types.str;
            readOnly = true;
          };

          finalPackage = lib.mkOption {
            type = lib.types.package;
            readOnly = true;
          };

          finalHome = lib.mkOption {
            type = lib.types.unspecified;
            readOnly = true;
          };

          packageModule = lib.mkOption {
            type = lib.types.unspecified;
            readOnly = true;
          };
        };

        config = {
          entryPoint = import "${self}/profiles/users/${config.username}" (inputs // { inherit self; });
          base =
            if lib.strings.hasSuffix "-darwin" config.system
            then "Users"
            else "home";
          homeDirectory = "/${config.base}/${config.username}";

          finalModules =
            [
              config.entryPoint
              {home = {inherit (config) username homeDirectory;};}
              self.homeModules
              # self.mixedModules
            ]
            ++ config.modules;

          packageName = "home/config/${name}";
          finalPackage = config.finalHome.activationPackage;

          packageModule = {${config.system}.${config.packageName} = config.finalPackage;};

          finalHome = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = config.nixpkgs.legacyPackages.${config.system};
            modules = config.finalModules;
          };
        };
      }));
    };
  };

  config.cauldron.homeConfigurations."rbatty@fang".system = "aarch64-darwin";
  config.cauldron.homeConfigurations."rbatty@luna".system = "aarch64-darwin";
  config.cauldron.homeConfigurations."rbatty@selene".system = "x86_64-linux";

  config.flake.homeConfigurations = configs;
  config.flake.packages = lib.mkMerge packages;
}
