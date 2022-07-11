{ config, lib, pkgs, ... }:
let
  shellAliases = (import ../common/aliases.nix)
  // (import ../common/abbrs.nix);
in
{
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
      "histreeddit"
      "checkwinsize"
      "nocaseglob"
      "globstar"
      "no_empty_cmd_completion"
      "noclobber"
    ];
  };

  programs.fzf.enableBashIntegration = true;
  programs.navi.enableBashIntegration = true;
  programs.zoxide.enableBashIntegration = true;
  programs.starship.enableBashIntegration = true;
}
