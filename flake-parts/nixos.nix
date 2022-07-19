{ inputs, lib, self, withSystem, ... }:
let
  inherit (lib) nixosSystem;
  inherit (inputs.nixpkgs.nixosModules) notDetected;
  inherit (inputs.home-manager.nixosModules) home-manager;
  # TODO: Add agenix to NixOS
  # inherit (inputs.agenix.nixosModules) age;


  mkNixos = { system, host, user }: withSystem system ({ pkgs, system, ... }:
    let
      configArgs = { config._module.args = { inherit inputs; flake = self; }; };
      baseModules = [ notDetected configArgs ];
      hostModule = ../nixos/hosts/${host};
      userImports = [ ../modules ../profiles/users/${user} ];
      homeManagerUsers = {
        home-manager.users.${user} = { imports = userImports; };
      };
      userModules = [ hostModule home-manager homeManagerUsers ];

    in nixosSystem {
      inherit pkgs system;
      modules = baseModules ++ userModules;
    });
in {
  flake = {
    nixosConfigurations = {
      koumori = mkNixos {
        system = "x86_64-linux";
        host = "koumori";
        user = "riizu";
      };
    };

    # packages.x86_64-linux = lib.attrsets.mapAttrs' (name: value:
    #   lib.attrsets.nameValuePair "nixos-${name}"
    #   value.config.system.build.toplevel) self.outputs.nixosConfigurations;
  };
}
