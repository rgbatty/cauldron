{ self
, inputs
, ...
}:
let
  inherit (inputs) digga;
in
{
  imports = [ (digga.lib.importExportableModules ./modules) ];
  modules = [ ];
  importables = rec {
    profiles = digga.lib.rakeLeaves ./profiles;
    suites = with profiles; rec {
      base = [ direnv git ];
    };
  };
  users = {
    rbatty = { suites, ... }: { imports = suites.base; };
  };
}
