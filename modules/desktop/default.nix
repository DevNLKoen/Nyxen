{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./compositors
    ./kitty.nix
    ./rofi.nix
  ];

  options.nyxen.desktop.enable = lib.mkEnableOption "Enable desktop applications";

  config = lib.mkIf config.nyxen.desktop.enable {
    nyxen.desktop = {
      kitty.enable = lib.mkDefault true;
      rofi.enable = lib.mkDefault true;
    };

    services.solaar.enable = true;

    environment.systemPackages = with pkgs; [
      bibata-cursors
      brightnessctl
      copyq
      flameshot
      swww
      waybar
    ];
  };
}
