{ config, lib, pkgs, modulesPath, ... }:

{
    imports =
        [ (modulesPath + "/installer/scan/not-detected.nix")
        ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
        { device = "/dev/disk/by-uuid/59ed866e-6463-4f5c-99fc-0602dda11b84";
        fsType = "ext4";
        };

    fileSystems."/boot/efi" =
        { device = "/dev/disk/by-uuid/EE50-41C7";
           fsType = "vfat";
        };

    swapDevices =
        [ { device = "/dev/disk/by-uuid/75a191fa-24d5-4b60-9964-343296eff202"; }
        ];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
