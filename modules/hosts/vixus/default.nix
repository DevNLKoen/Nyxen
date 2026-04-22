{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.vixus = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.vixusConfiguration
    ];
  };
}
