{ inputs, self, withSystem, ... }: {
  flake = let
    inherit (inputs.darwin.lib) darwinSystem;
    inherit (inputs.home-manager.darwinModules) home-manager;

    mkDarwin = system: { host, users }:
      withSystem system ({ pkgs, ... }:
        darwinSystem {
          inherit pkgs system;

          inputs = { inherit users; };
          modules = [ home-manager ../profiles/systems/darwin/hosts/${host} ];
        });

    mkDarwinArm = mkDarwin "aarch64-darwin";
    mkDarwinIntel = mkDarwin "x86_64-darwin";
  in {
    darwinConfigurations = {
      luna = mkDarwinArm { host = "luna"; users = ["rbatty"]; };
      fang = mkDarwinIntel { host = "fang"; users = ["rbatty"]; };
    };

    packages = with self.outputs.darwinConfigurations; {
      aarch64-darwin.darwin-luna = luna.config.system.build.toplevel;
      x86_64-darwin.darwin-fang = fang.config.system.build.toplevel;
    };
  };
}
