{
  self,
  inputs,
  ...
}: {
  flake.wrapperModules.kitty = {
    config,
    lib,
    ...
  }: {
    config = {
      settings = {
        enable_audio_bell = "no";
        background_opacity = 0.9;
        font_family = "JetBrainsMono Nerd Font";
      };
    };
  };
  perSystem = {pkgs, ...}: {
    packages.kitty =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;
        imports = [self.wrapperModules.kitty];
      }).wrapper;
  };
}
