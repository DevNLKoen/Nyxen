{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.umbrynConfiguration = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.umbrynHardware
      self.nixosModules.commonConfiguration
      self.nixosModules.desktop
      self.nixosModules.games
      inputs.cwc.nixosModules.cwc
    ];

    # nyxen options from modules
    nyxen = {
      name = "umbryn";
      # flatpak.enable = true;
    };

    xdg.portal = {
      enable = true;
      wlr = {
        enable = true;
        settings.screencast = {
          chooser_cmd = "${self.packages.${pkgs.stdenv.hostPlatform.system}.rofi}/bin/rofi -dmenu -i -p 'eg'";
          chooser_type = "dmenu";
        };
      };
    };

    programs = {
      cwc.enable = true;
      firefox.enable = true;
      kdeconnect.enable = true;
    };

    environment.systemPackages = with pkgs; [
      framework-tool
      tuigreet
      pulseaudio
      playerctl
    ];

    services = {
      desktopManager.plasma6.enable = true;
      # Audio
      pulseaudio.enable = false;

      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # jack.enable = true;
      };
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = ''              ${pkgs.tuigreet}/bin/tuigreet --time \
                        --cmd -- "uwsm start default"'';
          };
          user = "greeter";
        };
      };
      minidlna = {
        enable = true;
        openFirewall = true;
        settings = {
          media_dir = [
            "/home/nlkoen/Videos"
          ];
          friendly_name = "umbryn laptop";
          inotify = "yes";
        };
      };
    };

    security = {
      rtkit.enable = true;
      polkit.enable = true;
    };

    # Bootloader.
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
        timeout = 0;
      };
      plymouth = {
        enable = true;
      };
      # kernelPackages = pkgs.linuxPackages_latest;
    };
    environment.sessionVariables = {
      NH_FLAKE = lib.mkForce "/home/nlkoen/nyxen";
    };

    # System info
    system.stateVersion = "25.05";
  };
}
