# inputs: { config, lib, pkgs, ... }:

# with lib;
# {
#   imports = [ ../common.nix ];

#   config = {
#     nix = {
#       settings.trusted-users = [ "root" "@wheel" ];
#     };

#     ## Some reasonable, global defaults
#     # This is here to appease 'nix flake check' for generic hosts with no
#     # hardware-configuration.nix or fileSystem config.
#     fileSystems."/".device = mkDefault "/dev/disk/by-label/nixos";

#     # The global useDHCP flag is deprecated, therefore explicitly set to false
#     # here. Per-interface useDHCP will be mandatory in the future, so we enforce
#     # this default behavior here.
#     networking.useDHCP = mkDefault false;

#     # Use the latest kernel
#     boot = {
#       # kernelPackages = mkDefault pkgs.linuxKernel.packages.linux_5_16;
#       loader = {
#         efi.canTouchEfiVariables = mkDefault true;
#         systemd-boot.configurationLimit = 10;
#         systemd-boot.enable = mkDefault true;
#       };
#     };

#     # Just the bear necessities...
#     environment.systemPackages = with pkgs; [
#       bind
#       gnumake
#       dosfstools
#       gptfdisk
#       iputils
#       usbutils
#       utillinux
#     ];
#   };
# }

_: {config, lib, pkgs, ...}: {
    # {boot.cleanTmpDir = true;}
    # {networking.hostName = name;}
    # {system.configurationRevision = self.rev or "dirty";}
    # {documentation.man.enable = true;}
    # {documentation.man.generateCaches = true;}
    # inputs.sops-nix.nixosModules.sops

    nixpkgs.config.allowUnfree = true;

    nix = {
        settings = {
        # auto-optimise-store = mkDefault true;
        experimental-features = [ "nix-command" "flakes" ];
        # trusted-users = mkDefault [ "root" "@wheel" ];
        };
    };

    environment.systemPackages = with pkgs; [
        unzip
        vim
        wget
    ];

    time.timeZone = "America/Denver";

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

    services.openssh.enable = true;
    # home-manager = {
    #   backupFileExtension = "backup";
    #   sharedModules = [ ../home ];
    #   useGlobalPkgs = true;
    #   useUserPackages = true;
    # };



    #   gc = {
    #     automatic = true;
    #   };

    # };
    system.stateVersion = "22.11";
}