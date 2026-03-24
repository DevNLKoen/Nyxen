{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.vixus = inputs.nixpkgs.liblnixosSystem {
    modules = [
      self.nixosModules.vixusConfiguration
    ];
  };
}
