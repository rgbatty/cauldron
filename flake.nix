{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-xivlauncher.url = "github:nixos/nixpkgs/2504cd307496949ef88f40fadfd7369381fc8ddf";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/v0.37.1";
    };

    lan-mouse.url = "github:feschber/lan-mouse";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-xivlauncher, home-manager, ... }: {
    nixosConfigurations = {
      selene = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;

          pkgs-xivlauncher = import nixpkgs-xivlauncher {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          ./modules/nixos
          ./hosts/nixos/selene
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.riizu = import ./modules/home/nixos;
            home-manager.extraSpecialArgs = { inherit inputs;};
          }
        ];
      };

      nosferatu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/nixos
          ./hosts/nixos/nosferatu
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.riizu = import ./modules/home/nixos;
            home-manager.extraSpecialArgs = { inherit inputs;};
          }
        ];
      };
    };
  };
}
