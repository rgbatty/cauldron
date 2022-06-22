{
  description = "A highly structured configuration database.";

  nixConfig.extra-experimental-features = "nix-command flakes";
  nixConfig.extra-substituters = "https://nrdxp.cachix.org https://nix-community.cachix.org";
  nixConfig.extra-trusted-public-keys = "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";

  inputs =
    {
      # Channels
      nixos.url = "github:nixos/nixpkgs/nixos-21.11";
      latest.url = "github:nixos/nixpkgs/nixos-unstable";
      nixpkgs-darwin-stable.url = "github:NixOS/nixpkgs/nixpkgs-21.11-darwin";
      darwin.url = "github:LnL7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs-darwin-stable";

      # Framework
      digga.url = "github:divnix/digga";
      digga.inputs.nixpkgs.follows = "nixos";
      digga.inputs.nixlib.follows = "nixos";

      # System
      nixos-hardware.url = "github:nixos/nixos-hardware";
      nixos-generators.url = "github:nix-community/nixos-generators";

      # Home
      home.url = "github:nix-community/home-manager/release-21.11";
      home.inputs.nixpkgs.follows = "nixos";
      digga.inputs.home-manager.follows = "home";

      # Deploy
      deploy.url = "github:serokell/deploy-rs";
      deploy.inputs.nixpkgs.follows = "nixos";
      digga.inputs.deploy.follows = "deploy";

      # Secrets
      agenix.url = "github:ryantm/agenix";
      agenix.inputs.nixpkgs.follows = "nixos";

      # Nvfetcher
      nvfetcher.url = "github:berberman/nvfetcher";
      nvfetcher.inputs.nixpkgs.follows = "nixos";

      # Tooling
      bud.url = "github:divnix/bud";
      bud.inputs.nixpkgs.follows = "nixos";
      bud.inputs.devshell.follows = "digga/devshell";
    };

  outputs =
    { self
    , digga
    , bud
    , nixos
    , home
    , nixos-hardware
    , nur
    , agenix
    , nvfetcher
    , deploy
    , nixpkgs
    , ...
    } @ inputs:
    digga.lib.mkFlake
      {
        inherit self inputs;

        channelsConfig = { allowUnfree = true; };

        channels = {
          nixos = {
            imports = [ (digga.lib.importOverlays ./overlays) ];
            overlays = [ ];
          };
          nixpkgs-darwin-stable = {
            imports = [ (digga.lib.importOverlays ./overlays) ];
            overlays = [ ];
          };
          latest = { };
        };

        lib = import ./lib { lib = digga.lib // nixos.lib; };

        sharedOverlays = [
          (final: prev: {
            __dontExport = true;
            lib = prev.lib.extend (lfinal: lprev: {
              our = self.lib;
            });
          })

          nur.overlay
          agenix.overlay
          nvfetcher.overlay

          (import ./pkgs)
        ];

        nixos = {
          hostDefaults = {
            system = "x86_64-linux";
            channelName = "nixos";
            imports = [ (digga.lib.importExportableModules ./modules) ];
            modules = [
              { lib.our = self.lib; }
              digga.nixosModules.bootstrapIso
              digga.nixosModules.nixConfig
              home.nixosModules.home-manager
              agenix.nixosModules.age
              bud.nixosModules.bud
            ];
          };

          imports = [ (digga.lib.importHosts ./hosts/nixos) ];
          hosts = {
            koumori = { };
          };
          importables = rec {
            profiles = digga.lib.rakeLeaves ./profiles // {
              users = digga.lib.rakeLeaves ./home/users;
            };
            suites = with profiles; rec {
              base = [ core.nixos users.rbatty users.root ];
            };
          };
        };

        darwin = {
          hostDefaults = {
            system = "x86_64-darwin";
            channelName = "nixpkgs-darwin-stable";
            imports = [ (digga.lib.importExportableModules ./modules) ];
            modules = [
              { lib.our = self.lib; }
              digga.darwinModules.nixConfig
              home.darwinModules.home-manager
              agenix.nixosModules.age
            ];
          };

          imports = [ (digga.lib.importHosts ./hosts/darwin) ];
          hosts = {
            luna = {
              system = "aarch64-darwin";
            };
          };
          importables = rec {
            profiles = digga.lib.rakeLeaves ./profiles // {
              users = digga.lib.rakeLeaves ./home/users;
            };
            suites = with profiles; rec {
              base = [ core.darwin users.rbatty ];
            };
          };
        };

        home = ./home;

        devshell = ./shell;

        homeConfigurations = digga.lib.mergeAny
          (digga.lib.mkHomeConfigurations self.darwinConfigurations)
          (digga.lib.mkHomeConfigurations self.nixosConfigurations)
        ;

        deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

      }
  ;
}
