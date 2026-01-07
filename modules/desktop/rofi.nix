{
  packages,
  config,
  lib,
  ...
}: {
  options.nyxen.desktop.rofi.enable = lib.mkEnableOption "Enable Rofi with rofi-games plugin";

  config = lib.mkIf config.nyxen.desktop.rofi.enable {
    environment.systemPackages = [
      packages.rofi
    ];
  };
}
