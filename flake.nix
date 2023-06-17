{
  description = "Cauldron: A Colony of Bats and Other Witchcraft";

  inputs = {
    nixpkgs-2211.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    master.url = "github:nixos/nixpkgs/master";

    parts.url = "github:hercules-ci/flake-parts";

    # The following is required to make flake-parts work.
    nixpkgs.follows = "nixpkgs-unstable";
    unstable.follows = "nixpkgs-unstable";
    stable.follows = "nixpkgs-2211";

    # Known to work, try again after nixos/nix#8072 git fixed
    # https://github.com/NixOS/nix/issues/8072
    # nix.url = "github:nixos/nix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "unstable";

    # agenix.url = "github:ryantm/agenix";
    # agenix.inputs.nixpkgs.follows = "nixpkgs";

    # darwin.url = "github:LnL7/nix-darwin/master";
    # darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Extras
    # nixos-generators.url = "github:nix-community/nixos-generators";
    # nixos-hardware.url = "github:nixos/nixos-hardware";
    # emacs-overlay.url  = "github:nix-community/emacs-overlay";
  };


  outputs = { parts, ... } @ inputs:
    parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" ];
      imports = [
        ./parts/home-manager.nix
        ./parts/nixos.nix
      ];

      flake = {
        homeModules = import ./modules/home inputs;

        nixosModules = import ./modules/systems/nixos inputs;
      };
    };
}
