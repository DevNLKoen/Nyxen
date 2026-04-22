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
            hash = "sha256-eva8kFhA/29Zd1XfkAZrT1KsJvw3LShbO5lYnnKGEH4=";
          };
        };
      };
    };
  };
}
