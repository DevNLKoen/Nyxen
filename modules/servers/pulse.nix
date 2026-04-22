{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.pulse = {pkgs, ...}: {
    imports = [inputs.flux.nixosModules.default];

    nixpkgs.overlays = [inputs.flux.overlays.default];

    flux = {
      enable = true;
      servers = {
        pulse = {
          package = pkgs.mkMinecraftServer {
            name = "pulse";
            src = ./pulse;
            hash = "sha256-ugAovCO3T8YKPAdxVHr06GL0MFLZdJEeq/5vo9fBpgM=";
          };
        };
      };
    };
  };
}
