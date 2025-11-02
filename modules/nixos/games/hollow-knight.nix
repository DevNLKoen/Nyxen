{
  config,
  lib,
  pkgs,
  ...
}: {
  options.nyxen.games.hollow-knight.enable = lib.mkEnableOption "Enable Celeste and Olympus";

  config = lib.mkIf config.nyxen.games.hollow-knight.enable {
    environment.systemPackages = with pkgs; [
      lumafly
    ];
  };
}
