{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/226d6a3d-a75c-4c34-bcbc-1db688ad90a1";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/9eb4ee7b-e9f6-4cd4-9221-2d9ad662ad7c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5132-75A7";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/955d6fc1-6d70-40a7-bed4-9bc91ccc3c5e"; }
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #fileSystems."/".device = "/dev/mapper/wtf-vg111";
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/4c3c5ca2-d02a-4df0-8769-95ac7a330d6b";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.opengl.enable = true;
}
