{
  config,
  cwc,
  lib,
  ...
}: {
  imports = [
    cwc.nixosModules.cwc
  ];
  options.nyxen.desktop.compositors.cwc.enable = lib.mkEnableOption "Hackable wayland compositor";

  config = lib.mkIf config.nyxen.desktop.compositors.cwc.enable {
    programs.cwc.enable = true;
    nyxen.desktop.enable = true;
  };
}
