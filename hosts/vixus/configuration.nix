{...}: {
  imports = [
    ./hardware-configuration.nix
    ./../configuration.nix
  ];

  # nyxen options from modules
  nyxen = {
    desktop.enable = true;
    flatpak.enable = true;
  };

  # Bootloader.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        device = "nodev";
      };
    };
  };

  # System info
  system.stateVersion = "25.05";
}
