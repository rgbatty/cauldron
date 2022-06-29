{ self
, inputs
, ...
}:
let
  inherit (inputs) digga home;
in
{
  hostDefaults = {
    system = "x86_64-linux";
    channelName = "nixos";
    imports = [ (digga.lib.importExportableModules ../modules) ];
    modules = [
      digga.nixosModules.bootstrapIso
      digga.nixosModules.nixConfig
      home.nixosModules.home-manager
    ];
  };

  imports = [ (digga.lib.importHosts ./hosts) ];
  hosts = {
    koumori = { };
  };
  importables = rec {
    profiles = digga.lib.rakeLeaves ./profiles // {
      users = digga.lib.rakeLeaves ../home/users;
    };
    suites = with profiles; rec {
      base = [ nixos users.rgbatty users.root ];
    };
  };
}
