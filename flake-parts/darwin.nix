{ inputs, self, withSystem, ... }: {
  flake = let
    inherit (inputs.darwin.lib) darwinSystem;
    inherit (inputs.home-manager.darwinModules) home-manager;

    mkDarwin = system: host:
      withSystem system ({ pkgs, ... }:
        darwinSystem {
          inherit pkgs system;

          modules = [ ../modules/systems/darwin home-manager host ];
        });

    mkDarwinArm = mkDarwin "aarch64-darwin";
    mkDarwinIntel = mkDarwin "x86_64-darwin";
  in {
    darwinConfigurations = {
      luna = mkDarwinArm ../profiles/hosts/luna;
      fang = mkDarwinIntel ../profiles/hosts/fang;
    };

    packages = with self.outputs.darwinConfigurations; {
      aarch64-darwin.darwin-luna = luna.config.system.build.toplevel;
      x86_64-darwin.darwin-fang = fang.config.system.build.toplevel;
    };
  };
}
