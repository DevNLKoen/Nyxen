{
  packages,
  config,
  lib,
  ...
}: {
  options.nyxen.desktop.kitty.enable = lib.mkEnableOption "Enable Rofi with rofi-games plugin";

  config = lib.mkIf config.nyxen.desktop.kitty.enable {
    environment.systemPackages = [
      packages.kitty
    ];
  };
}
