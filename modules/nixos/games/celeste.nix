{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.nyxen.games.celeste.enable = lib.mkEnableOption "Enable Celeste and Olympus";

  config = lib.mkIf config.nyxen.games.celeste.enable {
      environment.systemPackages = with pkgs; [
        olympus
      ];
    };
}
