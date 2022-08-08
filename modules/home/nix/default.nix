# TODO: Nix configuration
# * aliasing
# Sources nix.sh based on install type
# Original: https://gist.github.com/colinxs/2898ecfb610ee613fef1329fe2c821d4
# Issue: https://github.com/nix-community/home-manager/issues/2012

{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.home.nix;

  inherit (lib) concatStringsSep optionalAttrs;

  profileDirectory = config.home.profileDirectory;
  defExprDirectory = "~/.nix-defexpr";

  sessionVariables =
    lib.optionalAttrs (cfg.nixProfiles != null) {
      NIX_PROFILES = (concatStringsSep " " cfg.nixProfiles);
    } // lib.optionalAttrs (cfg.nixPath != null) ({
      NIX_PATH = concatStringsSep ":" (lib.mapAttrsToList (n: v: "${n}=${v}") cfg.nixPath);
    }) // lib.optionalAttrs (cfg.nixSSLCertFile != null) {
      NIX_SSL_CERT_FILE = cfg.nixSSLCertFile;
    };

  # General idea: if a user sets a variable in home.sessionVariables
  # then we don't it overridden when we source nix(-daemon).sh
  # To do so we:
  # 1) Backup the variable if it exists
  # 2) Source nix(-daemon).sh
  # 3) Restore any backed up variables
  sourceNix =
    let
      # This is the same multiuser.nix from nixpkgs.nix-info
      multiUserTest = ./multiuser.nix;

      # To avoid conflicts with pre-existing variables
      magic = "DXHJGWAPDX";

      backupVar = var: ''
        if [ -n "''${${var}+x}" ]; then
          __${var}_${magic}=''$${var}
        fi
      '';
      restoreVar = var: ''
        if [ -n "''${__${var}_${magic}+x}" ]; then
          ${var}=$__${var}_${magic}
          unset __${var}_${magic}
        fi
      '';
    in
    ''
      source_nix_${magic}() {
        if [ "$ZSH_VERSION" ]; then
          # Zsh by default doesn't split words in unquoted parameter expansion.
          # Set local_options for these options to be reverted at the end of the function
          # and shwordsplit to force splitting words in $NIX_PROFILES below.
          setopt local_options shwordsplit
        fi
        for i in $NIX_PROFILES; do
          if [ -e "$i/etc/profile.d/$1" ]; then
            nixShPath="$i/etc/profile.d/$1"
          fi
        done
        # Source the last nix(-daemon.sh) we found, if we found one
        # $1 is one of nix(-daemon.sh)
        if [ -n "''${nixShPath+x}" ]; then
          . "$nixShPath"
        fi
      }
      ${backupVar "NIX_PROFILES"}
      ${backupVar "NIX_PATH"}
      ${backupVar "NIX_SSL_CERT_FILE"}
      ${if cfg.multiUser == true then "source_nix_${magic} nix-daemon.sh"
        else if cfg.multiUser == false then "source_nix_${magic} nix-sh"
        else ''
          if [ -e /etc/profile.d/nix.sh ]; then
            # Fast exit: this file exists on multi-user installs for non-NixOS
            # Not sure about NixOS
            source_nix_${magic} nix-daemon.sh
          elif command -v nix-build >/dev/null 2>&1 \
            && NIX_PATH=nixpkgs=${pkgs.path} nix-build --no-out-link ${multiUserTest} >/dev/null 2>&1; then
            # Otherwise, run the test script which takes a few seconds.
            # This is unusable for ZSH as hm-session-vars.sh gets sourced
            # in zshenv and so this would occur on every shell initialization.
            source_nix_${magic} nix-daemon.sh
          else
            # single-user install
            source_nix_${magic} nix.sh
          fi
        ''}

      ${restoreVar "NIX_PROFILES"}
      ${restoreVar "NIX_PATH"}
      ${restoreVar "NIX_SSL_CERT_FILE"}
      unset -f source_nix_${magic}
    '';
in {
  options.modules.home.nix = {
    enable = mkEnableOption "Whether to enable control over the Nix environment";

    multiUser = mkOption {
      type = types.nullOr types.bool;
      default = null;
      description = ''
        Whether this Nix installation is a multi-user install or not
        Defaults to auto-detection.
      '';
    };

    nixProfiles = mkOption {
      type = with types; nullOr (listOf str);
      default = [ "\${NIX_STATE_DIR:-/nix/var/nix}/profiles/default" profileDirectory ];
    };

    nixPath = mkOption {
      type = with types; nullOr (attrsOf str);
      default = null;
    };

    nixSSLCertFile = mkOption {
      type = with types; nullOr str;
      default = null;
    };

    nixDefExpr = mkOption {
      type = with types; nullOr (attrsOf str);
      default = null;
    };
  };

  config = mkIf (cfg.enable && pkgs.stdenv.isLinux) (mkMerge [
    {
      home.packages = with pkgs; [
        git
        gnugrep
        manix
        nix-diff
        nix-du
        nix-info
        nix-prefetch-git
        nix-tree
        nixfmt
        nixpkgs-fmt
        nixpkgs-review
      ] ++ pkgs.lib.optional (pkgs.stdenv.isLinux) pkgs.nix-serve;
    }
    {
      systemd.user.sessionVariables = mkIf pkgs.stdenv.isLinux sessionVariables;
      home.sessionVariables = sessionVariables;
      home.sessionVariablesExtra = sourceNix;
    }
    (mkIf (cfg.nixDefExpr != null) {
      # Make nix-env reflect NIX_PATH
      # Has to occur after linkGeneration otherwise
      # the calls to nix-env in the home-manager script
      # add the channels link
      # Gross but it works!
      home.activation.installNixDefExpr =
        let
          mkLink = name: src: "ln -s ${src} ${defExprDirectory}/${name}";
        in
        lib.hm.dag.entryAfter [ "linkGeneration" ] ''
          rm -rf ${defExprDirectory}
          mkdir ${defExprDirectory}
          ${lib.concatStringsSep "\n" (lib.mapAttrsToList mkLink cfg.nixDefExpr)}
        '';
    })
  ]);
}

  # nix aliases
    # n = "nix";
    # np = "n profile";
    # ni = "np install";
    # nr = "np remove";
    # ns = "n search --no-update-lock-file";
    # nf = "n flake";
    # nepl = "n repl '<nixpkgs>'";
    # srch = "ns nixos";
    # orch = "ns override";
    # mn = ''
    #   manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^ //' | sk --preview="manix '{}'" | xargs manix
    # '';
