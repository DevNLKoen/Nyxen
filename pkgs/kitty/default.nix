{
  pkgs,
  wrappers,
  ...
}:
(wrappers.wrapperModules.kitty.apply {
  pkgs = pkgs;
  "kitty.conf".path = ./kitty.conf;
}).wrapper
