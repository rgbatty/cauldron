{ inputs, lib, self, withSystem, ... }: {
  flake = let
    inherit (lib) nixosSystem;
    inherit (inputs.nixpkgs.nixosModules) notDetected;
    inherit (inputs.home-manager.nixosModules) home-manager;
    # TODO: Add agenix to NixOS
    # inherit (inputs.agenix.nixosModules) age;

    mkNixos = { system ? "x86_64-linux", host, users }: withSystem system ({ pkgs, system, ... }:
      nixosSystem {
        inherit pkgs system;

        specialArgs = { inherit inputs users; flake = self; };
        modules = [ notDetected home-manager ../nixos/hosts/${host} ];
      });
  in {
    nixosConfigurations =  {
      koumori = mkNixos { host = "koumori"; users = ["riizu"]; };
    };

    packages.x86_64-linux = lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "nixos-${name}"
      value.config.system.build.toplevel) self.outputs.nixosConfigurations;
  };
}
