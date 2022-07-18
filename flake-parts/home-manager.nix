{ inputs, self, withSystem, ... }:
let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;

  mkHome = { pkgs, host, users }:
    homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ../modules
        { home.stateVersion = "22.11"; }
        host
      ] ++ users;
    };

in {
  flake = {
    homeConfigurations = {
      "rbatty@Luna" = withSystem "aarch64-darwin" (ctx@{ pkgs, system, ... }:
        mkHome {
          inherit pkgs;
          host = ../profiles/hosts/luna;
          users = [ ../profiles/users/rbatty ];
        }
      );
      "riizu@Koumori" = withSystem "x86_64-linux" (ctx@{ pkgs, system, ... }:
        mkHome {
          inherit pkgs;
          host = ../profiles/hosts/koumori;
          users = [ ../profiles/users/riizu ];
        }
      );
    };
  };
}
