{
  pkgs,
  wrappers,
  ...
}:
wrappers.lib.wrapPackage {
  inherit pkgs;
  package = pkgs.fastfetch;
  flags = {
    "--config" = "${./conf.jsonc}";
    "--kitty" = "${./logo.png}";
  };
}
