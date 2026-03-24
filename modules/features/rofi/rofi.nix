{
  self,
  inputs,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.rofi = inputs.wrapper-modules.wrappers.rofi.wrap {
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
    };
  };
}
