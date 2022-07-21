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
        # TODO: Evaluate these for nixpkg equivalents
        # aaron-bond.better-comments
        # BriteSnow.vscode-toggle-quotes

        # TODO: these don't build... for some reason
        # bbenoist.nix
        # christian-kohler.path-intellisense
        # dracula-theme.theme-dracula
        # eamodio.gitlens
        # gruntfuggly.todo-tree
        # ms-azuretools.vscode-docker
        # ms-vsliveshare.vsliveshare
        # pkief.material-icon-theme
        # skellock.just
        # skyapps.fish-vscode
      ];

      userSettings = {
        breadcrumbs.enabled = true;

        editor.accessibilitySupport = "off";
        editor.bracketPairColorization.enabled = true;
        editor.cursorBlinking = "phase";
        editor.cursorStyle = "line";
        editor.dragAndDrop = false;
        editor.fontFamily = "'FiraCode', Consolas, 'Courier New', monospace";
        editor.fontLigatures = true;
        editor.fontSize = 15;
        # TODO: Re-evaluate formatOnSave (per-project?)
        # editor.formatOnSave = false;
        editor.glyphMargin = false;
        editor.lineHeight = 22;
        editor.linkedEditing = true;
        editor.minimap.enabled = false;
        editor.tabSize = 2;

        explorer.autoReveal = true;
        explorer.confirmDragAndDrop = false;
        explorer.confirmDelete = false;
        extensions.autoUpdate = true;

        files.autoSave = "afterDelay";
        files.autoSaveDelay = 100;
        files.insertFinalNewline = true;
        files.trimTrailingWhitespace = true;

        git.autofetch = false;
        git.inputValidationSubjectLength = 72;

        html.format.enable = true;
        html.format.endWithNewline = false;

        markdown.preview.scrollEditorWithPreview = true;
        markdown.preview.scrollPreviewWithEditor = true;

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

        # TODO: evaluate terminal settings for Darwin
        # terminal.explorerKind = "external";
        # terminal.external.osxExec = "iTerm.app";
        # terminal.integrated.fontFamily = "Inconsolata for Powerline"; // Install Powerline fonts for this to work
        # terminal.integrated.fontSize = 12;
        # terminal.integrated.shell.osx = "fish";

        window.title = "\${activeEditorMedium}\${separator}\${rootName}";
        window.zoomLevel = 1;
        workbench.colorTheme = "Dracula";

        workbench.editor.enablePreview = false;
        workbench.editor.highlightModifiedTabs = true;
        workbench.editor.tabCloseButton = "right";
        workbench.editor.tabSizing = "shrink";
        workbench.enableExperiments = false;
        workbench.panel.defaultLocation = "right";
        workbench.settings.enableNaturalLanguageSearch = false;
        workbench.statusBar.feedback.visible = false;
        workbench.sideBar.location = "right";
      };
    };
  };
}
