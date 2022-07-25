{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.shell.shells.bash;

  shellAliases = (import ../common/aliases.nix)
  // (import ../common/abbrs.nix);
in {
  options.modules.shell.shells.bash = with types; {
    enable = mkEnableOption "bash";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.bashInteractive ];

    programs.bash = {
      inherit shellAliases;

      enable = true;

      historyControl = ["ignorespace" "ignoredups"];
      historyFile = "${config.xdg.dataHome}/bash/.bash_history";
      historyFileSize = 16384;
      historySize = 32768;

      sessionVariables = {
        HISTTIMEFORMAT = "%Y-%m-%d %H:%M:%S  ";
        LESS_TERMCAP_md = "\${yellow}";
        MANPAGER = "less -X";
        LESS = "FIRSX";
      };

      shellOptions = [
        "histappend"
        "histreedit"
        "checkwinsize"
        "nocaseglob"
        "globstar"
        "no_empty_cmd_completion"
        # TODO - 'noclobber' is invalid
        # "noclobber"
      ];
    };
  };
}
