{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.nyxen.flatpak.enable = lib.mkEnableOption "Enable flatpak";

  config = lib.mkIf config.nyxen.flatpak.enable {
    services.flatpak = {
      enable = true;
      packages = [
        { appId = "com.jetbrains.PyCharm-Professional"; }
        { appId = "org.vinegarhq.Sober"; }
        { appId = "org.vinegarhq.Vinegar"; }
      ];
    };
  };
}
