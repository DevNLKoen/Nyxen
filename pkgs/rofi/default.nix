{
  pkgs,
  wrappers,
  ...
}:
(wrappers.wrapperModules.rofi.apply {
  pkgs = pkgs;
  plugins = [pkgs.rofi-games];
  settings = {
    modes = "window,drun,games";
    show-icons = true;
    sidebar-mode = true;
    drun-display-format = "{name}";
    terminal = "kitty";
  };
  theme = builtins.toString (./theme.rasi);
}).wrapper
