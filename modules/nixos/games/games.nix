{
  config,
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
    })
  ];
}
