{
  pkgs,
  wrappers,
  ...
}:
(wrappers.wrapperModules.kitty.apply {
  inherit pkgs;
  "kitty.conf".path = "${./kitty.conf}";
}).wrapper
