{ config, pkgs, lib, ... }:
let
  cfg = config.modules.home.common.shells.bash;
  shellAliases = import ./aliases.nix;
in
{
  options = {
    modules.home.common.shells.bash.enable = lib.mkEnableOption "Enable Bash";
  };

  config = lib.mkIf cfg.enable {
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
      ];
    };
  };
}
