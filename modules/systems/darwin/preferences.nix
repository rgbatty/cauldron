{ inputs, lib, config, pkgs, ... }: {
  system.defaults = {
    # Apple Firewall
    # alf = {};

    dock = {
      autohide = false;
      autohide-delay = "0.0";
      autohide-time-modifier = "1.0";
      # dashboard-in-overlay  = false;
      # Mission Control animation speeds
      # expose-animation-duration = "1.0";
      # launchanim = "true";
      # mineffect = ""; # 'genie', 'suck', 'scale'
      # minimize-to-application = true;
      # Re-arrange spaces based on use
      mru-spaces = false;
      orientation = "bottom";
      show-process-indicators = true;
      show-recents = false;
      showhidden = false;
      tilesize = 64;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      CreateDesktop = false;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv";
      # ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
    };

    loginwindow = {
      GuestEnabled = false;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = false;
      ApplePressAndHoldEnabled = false;
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSDocumentSaveNewDocumentsToCloud = false;
      "com.apple.swipescrolldirection" = false;
    };

    spaces = {
      spans-displays = false;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    # remapCapsLockToControl = true;
    # remapCapsLockToEscape = true;
  };
}
