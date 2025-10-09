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

  services.swww.enable = true;

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

    ### UI / Apps ###

    kitty = {
      enable = true;
      font.name = lib.mkForce "JetBrainsMono Nerd Font";
      settings = {
        background_opacity = 0.7;
        enable_audio_bell = false;
      };
    };

    rofi = {
      enable = true;
      plugins = [pkgs.rofi-games];
    };

    vesktop.enable = true;
    waybar.enable = true;

    ### CMD / TUI ###

    btop.enable = true;
    ripgrep.enable = true;

    ### fastfetch ###
    fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = ./../assets/fastfetch/Crim_smug.png;
          height = 17;
          padding = {
            left = 1;
            top = 1;
            right = 1;
          };
        };

        display = {
          separator = ": ";
          color = {
            keys = "light_red";
            title = "red";
          };
          key = {
            width = 16;
            type = "both";
          };
          bar = {
            width = 10;
            char = {
              elapsed = "■";
              total = "-";
            };
          };
          percent = {
            type = 9;
            color = {
              green = "green";
              yellow = "light_yellow";
              red = "light_red";
            };
          };
          size.binaryPrefix = "jedec";
        };
        modules = [
          "title"
          "separator"
          {
            type = "os";
            format = "{name} {version}";
          }
          "host"
          "kernel"
          {
            type = "packages";
            combined = true;
          }
          "cpu"
          "gpu"
          "memory"
          {
            type = "disk";
            key = "{name}";
          }
          {
            type = "battery";
            key = "Battery";
          }
          "shell"
          "de"
          {
            type = "command";
            key = "OS Age";
            text = ''
              birth_install=$(stat -c %W /)
              current=$(date +%s)
              time_progression=$((current - birth_install))
              days_difference=$((time_progression / 86400))
              echo $days_difference days"
            '';
          }
          "uptime"
          "datetime"
          {
            type = "player";
            key = "Player";
          }
          "media"
        ];
      };
    };
  };
}
