{
  config,
  lib,
  pkgs,
  awww,
  packages,
  ...
}: {
  imports = [
    ./compositors
  ];

  options.nyxen.desktop.enable = lib.mkEnableOption "Enable desktop applications";

  config = lib.mkIf config.nyxen.desktop.enable {
    services.solaar.enable = true;

    environment.systemPackages = with pkgs; [
      bibata-cursors
      scrcpy
      brightnessctl
      copyq
      flameshot
      awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
      waybar
      vesktop
      swaynotificationcenter
      lxqt.pavucontrol-qt
      godot
      protonvpn-gui
      packages.kitty
      packages.rofi
    ];
  };
}
