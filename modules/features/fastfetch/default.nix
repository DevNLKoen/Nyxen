{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    wrappers,
    ...
  }: {
    packages.fetch = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.fastfetch;
      flags = {
        "--config" = "${./conf.jsonc}";
        "--kitty" = "${./logo.png}";
      };
    };
  };
}
