{ config, lib, pkgs, ... }:

{
  imports = [
    ./nvidia.nix
    ./wayland.nix
    ./x11.nix
  ];

  environment.systemPackages = with pkgs; [
    bind
    blueman
    dosfstools
    gptfdisk
    gnumake
    iputils
    kitty
    neofetch
    parted
    pulseaudio
    wget
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.\
    unzip
    usbutils
    utillinux
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;

  programs.steam = {
    enable = true;
  };

  time.timeZone = "America/Denver";
}
