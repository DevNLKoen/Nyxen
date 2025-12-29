{
  config,
  self,
  lib,
  pkgs,
  ...
}: {
  options.nyxen.nvim.enable = lib.mkEnableOption "Enable nvim with nvf configuration";

  config = lib.mkIf config.nyxen.nvim.enable {
    environment.systemPackages = [
      self.nvim
    ];
  };
}
