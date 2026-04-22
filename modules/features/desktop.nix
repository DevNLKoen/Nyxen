{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.desktop = {
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      solaar
      bibata-cursors
      scrcpy
      brightnessctl
      copyq
      flameshot
      inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
      waybar
      vesktop
      swaynotificationcenter
      lxqt.pavucontrol-qt
      godot
      proton-vpn
      self.packages.${pkgs.stdenv.hostPlatform.system}.kitty
      self.packages.${pkgs.stdenv.hostPlatform.system}.rofi
    ];
  };
}
