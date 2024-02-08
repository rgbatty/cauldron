{
  self,
  nixpkgs,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.cauldron.darwinConfigurations;

  configs = builtins.mapAttrs (_: config: config.finalSystem) cfg;

  packages = builtins.attrValues (builtins.mapAttrs (_: config: config.packageModule) cfg);
in {
  options = {
    cauldron.darwinConfigurations = lib.mkOption {
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
          system = lib.mkOption {type = lib.types.enum ["x86_64-darwin" "aarch64-darwin"];};

          modules = lib.mkOption {
            type = lib.types.listOf lib.types.unspecified;
            default = [];
          };

          entryPoint = lib.mkOption {
            type = lib.types.unspecified;
            readOnly = true;
          };

          finalModules = lib.mkOption {
            type = lib.types.listOf lib.types.unspecified;
            readOnly = true;
          };

          configFolder = lib.mkOption {
            type = lib.types.str;
            readOnly = true;
          };

          finalSystem = lib.mkOption {
            type = lib.types.unspecified;
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

          packageModule = lib.mkOption {
            type = lib.types.unspecified;
            readOnly = true;
          };
        };

        config = {
          configFolder = "${self}/profiles/hosts/darwin";
          entryPoint = import "${config.configFolder}/${name}" (inputs // {inherit self;});

          finalModules =
            [
              inputs.home-manager.darwinModules.home-manager
              {
                home-manager.backupFileExtension = "backup";
                home-manager.sharedModules = [self.homeModules];
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
              }
            ]
            ++ config.modules
            ++ builtins.attrValues {
              inherit (config) entryPoint;
            }
            ++ builtins.attrValues self.darwinModules
            ++ builtins.attrValues self.mixedModules;

          packageName = name;
          finalPackage = config.finalSystem.config.system.build.toplevel;

          packageModule = {${config.system}.${config.packageName} = config.finalPackage;};

          finalSystem = inputs.darwin.lib.darwinSystem {
            inherit (config) system;

            modules = config.finalModules;
          };
        };
      }));
    };
  };

  config.cauldron.darwinConfigurations.luna.system = "aarch64-darwin";
  config.cauldron.darwinConfigurations.fang.system = "x86_64-darwin";

  config.flake.darwinConfigurations = configs;

  config.flake.packages = lib.mkMerge packages;
}