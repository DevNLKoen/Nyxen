{
  pkgs,
  aagl,
  cwc,
  lib,
  ...
}: {
  imports = [
    aagl.nixosModules.default
    ./hardware-configuration.nix
    ./../configuration.nix
  ];

  # nyxen options from modules
  nyxen = {
    name = "umbryn";
    desktop.compositors.cwc.enable = true;
    desktop.compositors.niri.enable = true;
    games.enable = true;
    flatpak.enable = true;
  };

  programs = {
    firefox.enable = true;
    kdeconnect.enable = true;
  };

  environment.systemPackages = with pkgs; [
    framework-tool
    tuigreet
    pulseaudio
    playerctl
    wlr-which-key
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
          command = "${pkgs.tuigreet}/bin/tuigreet -r --user-menu --cmd ${cwc.packages.${pkgs.system}.default}/bin/cwc";
        };
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
}
