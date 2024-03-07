inputs: { config, pkgs, home-manager, ... }: let
    rgbatty = import "${inputs.self}/profiles/users/rbatty" inputs;
in {
    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";

    # Networking
    networking.hostName = "carmilla";
    # networking.wireless.enable = true;

    # networking.proxy.default = "http://user:password@proxy:port/";
    #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    networking.networkmanager.enable = true;

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

    # Configure keymap in X11
    services.xserver = {
        layout = "us";
        xkbVariant = "";
    };

    users.users.rgbatty = {
        isNormalUser = true;
        description = "Ryan";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };

    home-manager.users.rgbatty = {
      home.username = "rgbatty";
      home.homeDirectory = "/home/rgbatty"; 
      imports = [ rgbatty ];
    };
}