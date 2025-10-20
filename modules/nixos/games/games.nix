{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.nyxen.games;
in {
  options.nyxen.games = {
    enable = lib.mkEnableOption "Enable all games";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      nyxen.games.prismlauncher.enable = lib.mkDefault true;
      programs = {
          steam.enable = lib.mkDefault true;
          gamescope.enable = lib.mkOptionDefault true;
          gamemode.enable = lib.mkDefault true;
          sleepy-launcher.enable = lib.mkDefault true;
          honkers-launcher.enable = lib.mkDefault true;
          honkers-railway-launcher.enable = lib.mkDefault true;
      };

      environment.systemPackages = with pkgs; [
        lutris
      ];
    })
  ];
}
