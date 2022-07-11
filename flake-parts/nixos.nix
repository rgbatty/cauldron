{ inputs, lib, self, withSystem, ... }:
let
  inherit (inputs.home-manager.nixosModules) home-manager;
  # inherit (inputs.nixpkgs.nixosModules) notDetected;

  mkNixos = machineConfig: { pkgs, system }:
    lib.nixosSystem {
      inherit pkgs system;

      modules = [
        {
          config._module.args = {
            inherit inputs;
            flake = self;
          };
        }
        # notDetected
        # inputs.agenix.nixosModules.age
        home-manager
        machineConfig
      ];
    };
in {
  flake = {
    nixosConfigurations = withSystem "x86_64-linux" ({ pkgs, system, ... }: {
      koumori = mkNixos ../profiles/hosts/koumori { inherit pkgs system; };
    });

    # packages.x86_64-linux = lib.attrsets.mapAttrs' (name: value:
    #   lib.attrsets.nameValuePair "nixos-${name}"
    #   value.config.system.build.toplevel) self.outputs.nixosConfigurations;
  };
}
