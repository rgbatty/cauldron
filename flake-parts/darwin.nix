{ inputs, self, withSystem, ... }:
let
  inherit (inputs.home-manager.darwinModules) home-manager;

  mkDarwin = system: host:
    withSystem system ({ pkgs, ... }:
      inputs.darwin.lib.darwinSystem {
        inherit pkgs system;
        inputs = { inherit (inputs) darwin; };
        modules = [
          home-manager
          host
        ];
      });

  mkDarwinArm = mkDarwin "aarch64-darwin";
  mkDarwinIntel = mkDarwin "x86_64-darwin";
in {
  flake = {
    darwinConfigurations = {
      luna = mkDarwinArm ../hosts/darwin/luna;
      fang = mkDarwinIntel ../hosts/darwin/fang;
    };

    packages = with self.outputs.darwinConfigurations; {
      aarch64-darwin.darwin-luna = luna.config.system.build.toplevel;
      x86_64-darwin.darwin-fang = fang.config.system.build.toplevel;
    };
  };
}
