{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.games = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.prismlauncher
      inputs.aagl.nixosModules.default
    ];
    programs = {
      steam.enable = true;
      gamescope.enable = true;
      gamemode.enable = true;
      anime-games-launcher.enable = true;
      sleepy-launcher.enable = true;
      honkers-launcher.enable = true;
      honkers-railway-launcher.enable = true;
    };
    environment.systemPackages = with pkgs; [
      olympus
      lumafly
      lutris
    ];
  };
}
