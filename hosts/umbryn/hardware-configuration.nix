{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = ["xhci_pci" "vmd" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci"];
    initrd.kernelModules = [];
    kernelModules = ["cros_ec" "cros_ec_lpcs"];
    kernelParams = ["amdgpu.dcdebugmask=0x10" "amd_pstate=active"];
    extraModulePackages = with config.boot.kernelPackages; [framework-laptop-kmod];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/1220327c-43b1-46c9-8d16-3ca0cdd1ac62";
      fsType = "btrfs";
      options = ["subvol=@"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/20CD-DCC4";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    "/home/nlkoen/Games" = {
      device = "/dev/disk/by-uuid/33a6f154-4fb2-45a2-9d02-666ca4648d32";
      fsType = "ext4";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/1cc5aed5-a592-438a-a9ef-6c83c6ebd88a";
      fsType = "ext4";
    };
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  services = {
    fwupd.enable = true;
    fstrim.enable = true;
    fprintd.enable = true;
    power-profiles-daemon.enable = true;
    xserver.videoDrivers = ["nvidia"];
  };

  hardware = {
    graphics.enable = true;
    sensor.iio.enable = true;
    keyboard.qmk.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = lib.mkDefault "PCI:194:0:0";
        nvidiaBusId = lib.mkDefault "PCI:193:0:0";
      };
    };
    cpu.amd.updateMicrocode = true;
  };
}
