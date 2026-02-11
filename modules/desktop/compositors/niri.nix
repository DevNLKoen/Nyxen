{
  config,
  lib,
  ...
}: {
  options.nyxen.desktop.compositors.niri.enable = lib.mkEnableOption "Scrollable wayland compositor";

  config = lib.mkIf config.nyxen.desktop.compositors.niri.enable {
    programs.niri = {
      enable = true;
      useNautilus = false;
    };
    nyxen.desktop.enable = true;
  };
}
