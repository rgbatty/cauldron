{ inputs, lib, self, withSystem, ... }:
let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;


  mkHome = { pkgs, host, users }:
    homeManagerConfiguration {
      inherit pkgs;

      modules = users ++ [
        { home.stateVersion = "22.11"; }
        ../modules
        host
      ];

      extraSpecialArgs = {
        flake = self;
        homePrefix = if pkgs.stdenv.isDarwin then "/Users" else "/home";
      };
    };

in {
  flake = {
    homeConfigurations = {
      aarch64-darwin = withSystem "aarch64-darwin" (ctx@{ pkgs, ... }: {
        luna = mkHome {
          inherit pkgs;
          host = ../hosts/darwin/luna;
          users = [ ../profiles/users/rbatty ];
        };
      });

      x86_64-darwin = withSystem "x86_64-darwin" (ctx@{ pkgs, ... }: {
        fang = mkHome {
          inherit pkgs;
          host = ../hosts/darwin/fang;
          users = [ ../profiles/users/rbatty ];
        };
      });

      x86_64-linux = withSystem "x86_64-linux" (ctx@{ pkgs, ... }: {
        koumori = mkHome {
          inherit pkgs;
          host = ../hosts/nixos/koumori;
          users = [ ../profiles/users/riizu ];
        };
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
