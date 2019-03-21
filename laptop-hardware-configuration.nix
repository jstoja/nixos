# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = [ "kvm-intel" ];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];

      luks.devices = [{
        name = "root";
        device = "/dev/disk/by-uuid/621a8cac-ffcc-446e-b14c-568633006e60";
        preLVM = true;
        allowDiscards = true;
      }];
    };
    extraModprobeConfig = ''
      options i915 enable_rc6=1 enable_fbc=1
      options iwlwifi power_save=Y
      options iwldvm force_cam=N
    '';
  };

  fileSystems."/" = {
      device = "/dev/disk/by-uuid/84c9f071-efa7-43d6-a90c-14567abdae1b";
      fsType = "ext4";
      # SSD options
      options = [ "noatime" "nodiratime" "discard" ];
  };

  fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/81B9-B518";
      fsType = "vfat";
  };

  swapDevices =[
    { device = "/dev/disk/by-uuid/c9e40bd2-12df-42c6-a967-39b56f5f95ce"; }
  ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.opengl.enable = true;
}