{
  self,
  nixpkgs,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.cauldron.nixosConfigurations;

  configs = builtins.mapAttrs (_: config: config.finalSystem) cfg;

  packages = builtins.attrValues (builtins.mapAttrs (_: config: config.packageModule) cfg);
in {
  options = {
    cauldron.nixosConfigurations = lib.mkOption {
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
          system = lib.mkOption {type = lib.types.enum ["x86_64-linux" "aarch64-linux"];};

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

          bootloader = lib.mkOption {
            type = lib.types.str;
            readOnly = true;
          };

          hardware = lib.mkOption {
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
          configFolder = "${self}/profiles/hosts/nixos";
          entryPoint = import "${config.configFolder}/${name}" (inputs // {inherit self;});
          hardware = "${config.configFolder}/${name}/hardware.nix";
          # bootloader = "${config.configFolder}/${name}/bootloader.nix";
          

          finalModules =
            [
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.sharedModules = [self.homeModules];
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                # home-manager.users.rgbatty = {
                #   home.username = "rgbatty";
                #   home.homeDirectory = "/home/rgbatty"; 
                #   imports = [ rgbatty ];
                # };
              }
              inputs.hyprland.nixosModules.default
              {programs.hyprland.enable = true;}
            ]
            ++ config.modules
            ++ builtins.attrValues {
              inherit (config) entryPoint hardware; # bootloader
            }
            ++ builtins.attrValues self.nixosModules;
            # ++ builtins.attrValues self.mixedModules;

          packageName = "nixos/config/${name}";
          finalPackage = config.finalSystem.config.system.build.toplevel;

          packageModule = {${config.system}.${config.packageName} = config.finalPackage;};

          finalSystem = config.nixpkgs.lib.nixosSystem {
            inherit (config) system;

            modules = config.finalModules;
          };
        };
      }));
    };
  };

  # config.cauldron.nixosConfigurations.fang.system = "x86_64-linux";
  config.cauldron.nixosConfigurations.carmilla.system = "x86_64-linux";

  config.flake.nixosConfigurations = configs;
  config.flake.packages = lib.mkMerge packages;
}