{
  pkgs,
  aagl,
  cwc,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    aagl.nixosModules.default
    cwc.nixosModules.cwc
  ];

  # Bootloader.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Nix settings
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # System info
  system = {
    nixos.variantName = "Nyxen-victus16";
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

  virtualisation.waydroid.enable = true;

  networking = {
    hostName = "victus16";
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
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Input
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing
  services.printing.enable = true;

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  # User
  users.users.nlkoen = {
    isNormalUser = true;
    description = "NLKoen";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel" "input"];
  };

  # Programs
  services.flatpak.enable = true;

  programs = {
    cwc.enable = true;
    direnv.enable = true;
    zsh.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    git = {
      enable = true;
      config = {
        user.email = "94992822+DevNLKoen@users.noreply.github.com";
      };
    };

    firefox.enable = true;
    steam.enable = true;
    gamescope.enable = true;
    gamemode.enable = true;
    sleepy-launcher.enable = true;
    honkers-launcher.enable = true;
    honkers-railway-launcher.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
    lutris
    (prismlauncher.override {
      jdks = [
        temurin-jre-bin-25
        temurin-jre-bin
        temurin-jre-bin-17
        temurin-jre-bin-8
      ];
    })
    godot
    scrcpy
    alejandra
    nixd
    nh
    fd
    bibata-cursors
    pulseaudio
    playerctl
    brightnessctl
    flameshot
    copyq
  ];
  environment.sessionVariables = {
      NH_FLAKE = "/home/nlkoen/nix-config";
    };
}
