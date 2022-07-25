{
  description = "Cauldron: A Colony of Bats and Other Witchcraft";

  inputs = {
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "nixpkgs/master";
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs.follows = "nixpkgs";

    # Extras
    # nixos-generators.url = "github:nix-community/nixos-generators";
    # nixos-hardware.url = "github:nixos/nixos-hardware";
    # emacs-overlay.url  = "github:nix-community/emacs-overlay";
  };


  outputs = inputs @ { self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit self; } {
      imports = [ ./flake-parts ];
      systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" ];
    };
}
