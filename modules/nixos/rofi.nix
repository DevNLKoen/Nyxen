{ config, lib, pkgs, ... }:

let
  rofiWithGames = pkgs.rofi.override {
    plugins = [ pkgs.rofi-games ];
  };
in {
  options.nyxen.rofi.enable = lib.mkEnableOption "Enable Rofi with rofi-games plugin";

  config = lib.mkIf config.nyxen.rofi.enable {
    environment.systemPackages = [
      rofiWithGames
    ];
  };
}

