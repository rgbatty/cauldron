{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.editors.vscode;
in {
  options.modules.editors.vscode.enable = mkEnableOption "VS Code";

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions; [

      ];

      userSettings = {
        extensions.autoUpdate = true;
        git.autofetch = false;
        sync.askGistName = false;
        sync.autoDownload = false;
        sync.autoUpload = false;
        sync.forceDownload = false;
        sync.gist = "";
        sync.host = "";
        sync.pathPrefix = "";
        sync.quietSync = false;
        sync.removeExtensions = true;
        telemetry.enableCrashReporter = false;
        telemetry.enableTelemetry = false;
        window.zoomLevel = 1;
        # workbench.colorTheme = "";
        # workbench.enableExperiments = false;
        # workbench.settings.enableNaturalLanguageSearch = false;
        # workbench.statusBar.feedback.visible = false;
      };
    };
  };
}
