{ inputs, self, withSystem, ... }:
let
  inherit (inputs) darwin;
  inherit (darwin.lib) darwinSystem;
  inherit (inputs.home-manager.darwinModules) home-manager;

  mkDarwin = system: machineConfig:
    withSystem system ({ pkgs, ... }:
      darwinSystem {
        inherit pkgs system;
        inputs = { inherit (inputs) darwin; };
        modules =
          [ home-manager machineConfig ];
      });

  mkDarwinArm = mkDarwin "aarch64-darwin";
  mkDarwinIntel = mkDarwin "x86_64-darwin";
in {
  flake = {
    darwinConfigurations = {
      luna = mkDarwinArm ../darwin/hosts/luna;
      fang = mkDarwinIntel ../darwin/hosts/fang;
    };

    # packages = with self.outputs.darwinConfigurations; {
    #   luna = luna.config.system.build.toplevel;
    #   fang = fang.config.system.build.toplevel;
    # };
  };
}
