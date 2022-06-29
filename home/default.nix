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
      base = [ core ];
      alternateShells = [ shells.fish shells.zsh ];

      personal = base ++ alternateShells ++ [ qmk ];
    };
  };
  users = {
    rgbatty = { suites, ... }: { imports = suites.personal; };
  };
}
