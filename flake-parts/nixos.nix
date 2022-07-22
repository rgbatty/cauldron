{ inputs, lib, self, withSystem, ... }: {
  flake = let
    inherit (lib) nixosSystem;
    inherit (inputs.nixpkgs.nixosModules) notDetected;
    inherit (inputs.home-manager.nixosModules) home-manager;
    # TODO: Add agenix to NixOS
    # inherit (inputs.agenix.nixosModules) age;

    mkNixos = host: { system ? "x86_64-linux" }: withSystem system ({ pkgs, system, ... }:
      nixosSystem {
        inherit pkgs system;

        specialArgs = { inherit inputs; flake = self; };
        modules = [ notDetected home-manager host ];
      });
  in {
    nixosConfigurations =  {
      koumori = mkNixos ../profiles/hosts/koumori {};
    };

    packages.x86_64-linux = lib.attrsets.mapAttrs' (name: value:
      lib.attrsets.nameValuePair "nixos-${name}"
      value.config.system.build.toplevel) self.outputs.nixosConfigurations;
  };
}
