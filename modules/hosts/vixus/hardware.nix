{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.vixusHardware = {
    config,
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot = {
      initrd = {
        availableKernelModules = ["xhci_pci" "vmd" "nvme" "usbhid" "usb_storage" "sd_mod" "sdhci_pci"];
        kernelModules = [];
      };
      kernelModules = ["kvm-intel" "hp-wmi"];
      extraModulePackages = [];
    };

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/783f240b-5973-4cc6-8dd6-33afb22be4b4";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/8885-E844";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
