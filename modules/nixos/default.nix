{ config, lib, pkgs, ... }:

{
  imports = [
    ./gaming.nix
    ./nvidia.nix
    ./synergy.nix
    ./wayland.nix
    ./x11.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        # editor = false;
      };
      timeout = 10; # investigate
      efi = {
        canTouchEfiVariables = true;
        # efiSysMountPoint = "/boot";
      };
      # grub = {
      #   enable = true;
      #   device = "nodev";
      #   efiSupport = true;
      #   useOSProber = true;
      #   configurationLimit = 8;
      #   theme =
      #     pkgs.fetchFromGitHub
      #     {
      #       owner = "Lxtharia";
      #       repo = "minegrub-theme";
      #       rev = "193b3a7c3d432f8c6af10adfb465b781091f56b3";
      #       sha256 = "1bvkfmjzbk7pfisvmyw5gjmcqj9dab7gwd5nmvi8gs4vk72bl2ap";
      #     };
      # };
    };
  };

  environment.etc = {
    "resolv.conf".text = "nameserver 192.168.50.4\nnameserver 1.1.1.1\n";
  };

  environment.systemPackages = with pkgs; [
    bind
    blueman
    dosfstools
    git
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

  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;

  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    wireplumber.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  time.timeZone = "America/Denver";

  users.users.riizu = {
    isNormalUser = true;
    description = "Ryan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # discord
      # firefox
      # unetbootin
      vivaldi
    ];
    shell = pkgs.fish;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
