{
  config,
  self,
  lib,
  pkgs,
  ...
}: {
  options.nyxen.kitty.enable = lib.mkEnableOption "Enable Rofi with rofi-games plugin";

  config = lib.mkIf config.nyxen.kitty.enable {
    environment.systemPackages = [
      self.kitty
    ];
  };
}
