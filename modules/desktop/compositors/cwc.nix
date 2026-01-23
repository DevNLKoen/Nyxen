{
  config,
  cwc,
  lib,
  pkgs,
  ...
}: {
  imports = [
    cwc.nixosModules.cwc
  ];
  options.nyxen.desktop.compositors.cwc.enable = lib.mkEnableOption "Hackable wayland compositor";

  config = lib.mkIf config.nyxen.desktop.compositors.cwc.enable {
    programs.cwc.enable = true;
    environment.systemPackages = with pkgs; [
      swaynotificationcenter
    ];
    nyxen.desktop.enable = true;
  };
}
