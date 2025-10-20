{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nyxen.games.prismlauncher;

  customPrismLauncher = 
    (pkgs.prismlauncher.override {
        jdks = cfg.jdks;
      });
in {
  options.nyxen.games.prismlauncher = {
    enable = lib.mkEnableOption "Prismlauncher";
    jdks = lib.mkOption {
      type = with lib.types; listOf package;
      default = with pkgs; [
        temurin-jre-bin-25 # java 25
        temurin-jre-bin # java 21
        temurin-jre-bin-17 # java 17
        temurin-jre-bin-8 # java 8
      ];
      defaultText = lib.literalExpression ''
        [
          pkgs.temurin-jre-bin-25
          pkgs.temurin-jre-bin
          pkgs.temurin-jre-bin-17
          pkgs.temurin-jre-bin-8
        ]
      '';
      description = ''
        List of JDK packages to be used by PrismLauncher.
        If unset, defaults to a set of Temurin JREs (25, latest, 17, 8).
      '';
      example = lib.literalExpression ''
        [ pkgs.temurin-jre-bin pkgs.openjdk17 pkgs.graalvm-ce ]
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ customPrismLauncher ];
  };
}
