{
  description = "Cauldron: A Colony of Bats and Other Witchcraft";

  inputs = {
    agenix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:ryantm/agenix";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-darwin.url = "nixpkgs/nixpkgs-22.05-darwin";
    nixpkgs-master.url = "nixpkgs/master";
    nixpkgs.url = "nixpkgs/nixos-22.05";
    unstable.url = "nixpkgs/nixos-unstable";

    # System
    # nixos-hardware.url = "github:nixos/nixos-hardware";
    # nixos-generators.url = "github:nix-community/nixos-generators";
  };


  outputs = inputs @ { self, nixpkgs, home-manager, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit self; } {
      systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" ];

      imports = [
        # TODO: configure Darwin
        # ./flake-parts/darwin.nix
        ./flake-parts/home-manager.nix
        # TODO: configure NixOS
        # ./flake-parts/nixos.nix
      ];
    };
}

