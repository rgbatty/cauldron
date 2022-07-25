{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.desktop.media.recording;
in {
  options.modules.desktop.media.recording = {
    enable = mkEnableOption "Recording";
    audio.enable = mkEnableOption "Audio";
    video.enable = mkEnableOption "Video";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      # TODO: Broken package
      # for recording and remastering audio
      # (if cfg.audio.enable then [ pkgs.audacity-gtk3 pkgs.ardour ] else []) ++
      # TODO: Not supported on Darwin
      # for longer term streaming/recording the screen
      # (if cfg.video.enable then [ pkgs.obs-studio pkgs.handbrake ] else []);
      [];
  };
}
