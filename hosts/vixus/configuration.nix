{...}: {
  imports = [
    ./hardware-configuration.nix
    ./../configuration.nix
  ];

  # nyxen options from modules
  nyxen = {
    name = "vixus";
  };

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # System info
  system.stateVersion = "25.05";
}
