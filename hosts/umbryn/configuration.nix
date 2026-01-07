{
  pkgs,
  aagl,
  cwc,
  pinnacle,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    aagl.nixosModules.default
    pinnacle.nixosModules.default
  ];

  # nyxen options from modules
  nyxen = {
    desktop.compositors.cwc.enable = true;
    games.enable = true;
    flatpak.enable = true;
    nvim.enable = true;
  };

  # Bootloader.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
      timeout = 0;
    };
    plymouth = {
      enable = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Nix settings
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # System info
  system = {
    nixos.variantName = "Nyxen-Umbryn";
    stateVersion = "25.05";
  };

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
    hostName = "umbryn";
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
  security.rtkit.enable = true;
  security.polkit.enable = true;

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
    hyprland.enable = true;
    niri.enable = true;
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
    xwayland-satellite
    vesktop
    btop
    ripgrep
    fastfetch
    zsh
    starship
    framework-tool
  ];

  environment.sessionVariables = {
    NH_FLAKE = "/home/nlkoen/nixos";
  };
}
