{ config, options, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.home.desktop.media.recording;
in {
  options.modules.home.desktop.media.recording = {
    enable = mkEnableOption "Recording";
    audio.enable = mkEnableOption "Audio";
    video.enable = mkEnableOption "Video";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # for recording and remastering audio
      # (if cfg.audio.enable then [ pkgs.audacity-gtk3 pkgs.ardour ] else []) ++
      # for longer term streaming/recording the screen
      # (if cfg.video.enable then [ pkgs.obs-studio pkgs.handbrake ] else []);
    ];
  };
}
