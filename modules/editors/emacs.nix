{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.editors.emacs;
  emacsPackage = with pkgs; (
    if stdenv.isDarwin then emacsNativeComp else emacsPgtkNativeComp);
in {
  options.modules.editors.emacs = {
    enable = mkEnableOption "Emacs";
    doom = rec {
      enable = mkEnableOption "Doom Emacs";
      repoUrl = mkOption { default = "https://github.com/doomemacs/doomemacs"; };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      emacs-all-the-icons-fonts
      git
      (ripgrep.override {withPCRE2 = true;})
      gnutls
    ];

    home.sessionVariables = mkMerge [
      (mkIf cfg.doom.enable {
        # DOOMDIR = toString "${config.xdg.configHome}/doom";
        # PATH = [ "$XDG_CONFIG_HOME/emacs/bin" "$PATH" ];
      })
    ];

    programs.emacs = {
      enable = true;
      package = emacsPackage;
      extraPackages = epkgs: (with epkgs; [ vterm ]);
    };

    # TODO: Add emacs service config for linux

    home.activation = {
      installDoomEmacs = mkIf cfg.doom.enable (lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          if [ ! -d "$HOME/emacs" ]; then
            $DRY_RUN_CMD git clone --depth=1 --single-branch "${cfg.doom.repoUrl}" "$HOME/emacs"
          fi
        '');
    };

    # system.userActivationScripts = mkIf cfg.doom.enable {
    #   installDoomEmacs = ''
    #     if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
    #        git clone --depth=1 --single-branch "${cfg.doom.repoUrl}" "$XDG_CONFIG_HOME/emacs"
    #     fi
    #   '';
    # };
  };
}
