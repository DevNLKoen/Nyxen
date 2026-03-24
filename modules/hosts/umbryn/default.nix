{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.umbryn = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.umbrynConfiguration
    ];
  };
}
