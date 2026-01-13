{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./../configuration.nix
  ];

  # nyxen options from modules
  nyxen = {
    name = "umbryn";
    desktop.compositors.cwc.enable = true;
    games.enable = true;
    flatpak.enable = true;
  };

  environment.systemPackages = with pkgs; [
    framework-tool
  ];

  # Bootloader.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        device = "nodev";
      };
      timeout = 0;
    };
  };

  # System info
  system.stateVersion = "25.05";
}
