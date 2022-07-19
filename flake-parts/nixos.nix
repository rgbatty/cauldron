{ inputs, lib, self, withSystem, ... }:
let
  mkNixos = host: { pkgs, system }:
    lib.nixosSystem {
      inherit pkgs system;

      modules = [
        {
          config._module.args = {
            inherit inputs;
            flake = self;
          };
        }
        inputs.nixpkgs.nixosModules.notDetected
        # inputs.agenix.nixosModules.age
        inputs.home-manager.nixosModules.home-manager
        host
        ../hosts/nixos
      ];
    };
in {
  flake = {
    nixosConfigurations = withSystem "x86_64-linux" ({ pkgs, system, ... }: {
      koumori = mkNixos ../hosts/nixos/koumori { inherit pkgs system; };
    });

    packages.x86_64-linux = lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "nixos-${name}"
      value.config.system.build.toplevel) self.outputs.nixosConfigurations;
  };
}
