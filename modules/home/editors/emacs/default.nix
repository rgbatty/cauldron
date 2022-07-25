{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.editors.emacs;
  emacsPackage = with pkgs; (
    if stdenv.isDarwin then emacsNativeComp else emacsPgtkNativeComp);
in {
  options.modules.home.editors.emacs = {
    enable = mkEnableOption "Emacs";
    doom = rec {
      enable = mkEnableOption "Doom Emacs";
      repoUrl = mkOption { default = "https://github.com/doomemacs/doomemacs"; };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      coreutils
      emacs-all-the-icons-fonts
      fd
      git
      (ripgrep.override {withPCRE2 = true;})
      gnutls
    ];

    home.sessionVariables = mkMerge [
      # { EDITOR = "emacsclient -t -a ''"; }
      (mkIf cfg.doom.enable {
        DOOMDIR = toString "${config.xdg.configHome}/doom";
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
          if [ ! -d "${config.home.homeDirectory}/emacs" ]; then
            $DRY_RUN_CMD git clone --depth=1 --single-branch "${cfg.doom.repoUrl}" "${config.home.homeDirectory}/emacs"
          fi
        '');
    };

    xdg.configFile.doom.source = config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/config/doom";
  };
}
