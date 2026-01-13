{
  pkgs,
  config,
  aagl,
  cwc,
  lib,
  pinnacle,
  ...
}: let
  systemName = config.nyxen.name;
in {
  imports = [
    aagl.nixosModules.default
    pinnacle.nixosModules.default
  ];
  options.nyxen.name = lib.mkOption {
    type = lib.types.str;
    description = "base system name";
  };

  config = {
    nyxen.nvim.enable = true;

    # Bootloader.
    boot = {
      plymouth = {
        enable = true;
      };
      kernelPackages = pkgs.linuxPackages_latest;
    };

    # Nix settings
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nixpkgs.config.allowUnfree = true;

    # System info
    system.nixos.variantName = "Nyxen-${systemName}";

    # Fonts
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    # Hardware & Virtualization
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    networking = {
      hostName = systemName;
      networkmanager.enable = true;
    };

    # Locale & Time
    time.timeZone = "Europe/Amsterdam";

    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "nl_NL.UTF-8";
        LC_IDENTIFICATION = "nl_NL.UTF-8";
        LC_MEASUREMENT = "nl_NL.UTF-8";
        LC_MONETARY = "nl_NL.UTF-8";
        LC_NAME = "nl_NL.UTF-8";
        LC_NUMERIC = "nl_NL.UTF-8";
        LC_PAPER = "nl_NL.UTF-8";
        LC_TELEPHONE = "nl_NL.UTF-8";
        LC_TIME = "nl_NL.UTF-8";
      };
    };

    # Display & Desktop
    services = {
      # Input
      xserver.xkb = {
        layout = "us";
        variant = "";
      };

      # Printing
      printing.enable = true;

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
            command = "${pkgs.greetd}/bin/agreety --cmd ${cwc.packages.${pkgs.system}.default}/bin/cwc";
          };
        };
      };
    };
    security = {
      rtkit.enable = true;
      polkit.enable = true;
    };
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      wlr.enable = true;
    };

    # User
    users.users.nlkoen = {
      isNormalUser = true;
      description = "NLKoen";
      shell = pkgs.zsh;
      extraGroups = ["networkmanager" "wheel" "input"];
    };

    # Programs
    programs = {
      pinnacle = {
        enable = true;
        package = pinnacle.packages.${pkgs.system}.pinnacle;
        xdg-portals.enable = true;
      };
      direnv.enable = true;
      dconf.enable = true;
      zsh.enable = true;

      git = {
        enable = true;
        config = {
          user.email = "94992822+DevNLKoen@users.noreply.github.com";
        };
      };
      firefox.enable = true;
    };

    environment.systemPackages = with pkgs; [
      wget
      scrcpy
      alejandra
      nixd
      nh
      fd
      pulseaudio
      playerctl
      vesktop
      btop
      ripgrep
      fastfetch
      zsh
      starship
    ];

    environment.sessionVariables = {
      NH_FLAKE = "/home/nlkoen/nyxen";
    };
  };
}
