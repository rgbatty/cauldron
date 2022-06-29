{ self
, inputs
, ...
}:
let
  inherit (inputs) digga home;
in
{
  hostDefaults = {
    system = "x86_64-darwin";
    channelName = "nixpkgs-darwin-stable";
    imports = [ (digga.lib.importExportableModules ../modules) ];
    modules = [
      digga.darwinModules.nixConfig
      home.darwinModules.home-manager
    ];
  };

  imports = [ (digga.lib.importHosts ./hosts) ];
  hosts = {
    luna = {
      system = "aarch64-darwin";
    };
    fang = {};
  };
  importables = rec {
    profiles = digga.lib.rakeLeaves ./profiles // {
      users = digga.lib.rakeLeaves ../home/users;
    };
    suites = with profiles; rec {
      base = [ darwin users.rgbatty ];
    };
  };
}
