{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.home.theme;
in {
  imports = [
    ./defaults
    ./dracula
  ];

  options.modules.home.theme = with types; {
    active = mkOption {
      type = str;
      default = "";
      apply = v: let theme = builtins.getEnv "THEME"; in
                 if theme != "" then theme else v;
      description = ''
        Name of the theme to enable. Can be overridden by the THEME environment
        variable. Themes can also be hot-swapped with 'just theme $THEME'.
      '';
    };

    onReload = mkOption { type = (attrsOf lines); default = {}; };
  };

  config = mkIf (cfg.active != "") (mkMerge [
    (mkIf (cfg.onReload != {})
      (let reloadTheme =
             with pkgs; (writeScriptBin "reloadTheme" ''
               #!${stdenv.shell}
               echo "Reloading current theme: ${cfg.active}"
               ${concatStringsSep "\n"
                 (mapAttrsToList (name: script: ''
                   echo "[${name}]"
                   ${script}
                 '') cfg.onReload)}
             '');
       in {
         home.packages = [ reloadTheme ];
         home.activation.reloadTheme = ''
           [ -z "$NORELOAD" ] && ${reloadTheme}/bin/reloadTheme
         '';
       }))
  ]);
}
