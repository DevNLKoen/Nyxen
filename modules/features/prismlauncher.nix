{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.prismlauncher = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher
    ];
  };
  perSystem = {pkgs, ...}: {
    packages.prismlauncher = pkgs.prismlauncher.override {
      jdks = with pkgs; [
        temurin-jre-bin-25 # java 25
        temurin-jre-bin # java 21
        temurin-jre-bin-17 # java 17
        temurin-jre-bin-8 # java 8
      ];
    };
  };
}
