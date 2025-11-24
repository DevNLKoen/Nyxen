{
  config,
  self,
  lib,
  ...
}: {
  options.nyxen.rofi.enable = lib.mkEnableOption "Enable Rofi with rofi-games plugin";

  config = lib.mkIf config.nyxen.rofi.enable {
    environment.systemPackages = [
      self.rofi
    ];
  };
}
