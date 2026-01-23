{
  pkgs,
  wrappers,
  ...
}:
(wrappers.wrapperModules.rofi.apply {
  inherit pkgs;
  plugins = [pkgs.rofi-games];
  settings = {
    modes = "window,drun,games";
    show-icons = true;
    sidebar-mode = true;
    drun-display-format = "{name}";
    terminal = "kitty";
  };
  theme = "${./theme.rasi}";
}).wrapper
