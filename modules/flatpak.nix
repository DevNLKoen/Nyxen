{
  config,
  lib,
  ...
}: {
  options.nyxen.flatpak.enable = lib.mkEnableOption "Enable flatpak";

  config = lib.mkIf config.nyxen.flatpak.enable {
    services.flatpak = {
      enable = true;
      packages = [
        {appId = "org.vinegarhq.Sober";}
      ];
    };
  };
}
