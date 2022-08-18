# TODO: Code Configuration
# * configure terminal usage
# * configure auto format

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.editors.vscode;
  vscodePname = config.programs.vscode.package.pname;

  configDir = {
    "vscode" = "Code";
    "vscode-insiders" = "Code - Insiders";
    "vscodium" = "VSCodium";
  }.${vscodePname};

  sysDir = if pkgs.stdenv.hostPlatform.isDarwin then
    "${config.home.homeDirectory}/Library/Application Support"
  else
    "${config.xdg.configHome}";

  userFilePath = "${sysDir}/${configDir}/User/settings.json";
in {
  options.modules.home.editors.vscode = {
    enable = mkEnableOption "VS Code";
    mutable = mkEnableOption "Mutable configuration";
  };

  config = mkIf cfg.enable {
    home = {
      activation = mkIf cfg.mutable {
        removeExistingVSCodeSettings = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
          rm -rf "${userFilePath}"
        '';

        overwriteVSCodeSymlink = let
          userSettings = config.programs.vscode.userSettings;
          jsonSettings = pkgs.writeText "tmp_vscode_settings" (builtins.toJSON userSettings);
        in lib.hm.dag.entryAfter [ "linkGeneration" ] ''
          rm -rf "${userFilePath}"
          cat ${jsonSettings} | ${pkgs.jq}/bin/jq --monochrome-output > "${userFilePath}"
        '';
      };
    };

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        christian-kohler.path-intellisense
        dracula-theme.theme-dracula
        eamodio.gitlens
        gruntfuggly.todo-tree
        ms-azuretools.vscode-docker
        pkief.material-icon-theme
        skellock.just
        skyapps.fish-vscode
      ]++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # TODO: Add these extensions to build directly
        # aaron-bond.better-comments
        # BriteSnow.vscode-toggle-quotes
        # Example:
        # {
        #   name = "vscode-docker";
        #   publisher = "ms-azuretools";
        #   version = "1.18.0";
        #   sha256 = "UPUfTOc5xJhI5ACm2oyWqtZ4zNxZjy16D6Mf30eHFEI=";
        # }
      ];
      package = pkgs.vscodium;
      userSettings = import ./settings.nix;
    };
  };
}
