{
  pkgs,
  lib,
  ...
}: {
  home = {
    username = "nlkoen";
    homeDirectory = "/home/nlkoen";
    stateVersion = "25.05";
    shell.enableZshIntegration = true;
  };

  programs = {
    ### Shell ###
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initContent = "fastfetch";
    };

    starship = {
      enable = true;
      settings = {
        username = {
          style_user = "red bold";
          format = "[$user]($style)";
          disabled = false;
          show_always = true;
        };
        directory = {
          style = "bold 202";
        };
      };
    };
  };
}
