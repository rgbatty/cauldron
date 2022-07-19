{ inputs, self, withSystem, ... }:
let
  inherit (inputs.darwin.lib) darwinSystem;
  inherit (inputs.home-manager.darwinModules) home-manager;

  mkDarwin = system: { host, users }:
    withSystem system ({ pkgs, ... }:
      darwinSystem {
        inherit pkgs system;
        inputs = { inherit (inputs) darwin; };
        modules = [
          host
          home-manager {
            home-manager.users = users;
          }
        ];
      });

  mkDarwinArm = mkDarwin "aarch64-darwin";
  mkDarwinIntel = mkDarwin "x86_64-darwin";
in {
  flake = {
    darwinConfigurations = {
      luna = mkDarwinArm {
        host = ../darwin/hosts/luna;
        users = {
          rbatty = {
            imports = [../modules ../profiles/users/rbatty];
          };
        };
      };
      # fang = mkDarwinArm {
      #   host = ../darwin/hosts/fang;
      #   users = [ ../profiles/users/rbatty ];
      # };
    };

    packages = with self.outputs.darwinConfigurations; {
      aarch64-darwin.darwin-luna = luna.config.system.build.toplevel;
      # x86_64-darwin.darwin-fang = fang.config.system.build.toplevel;
    };
  };
}
