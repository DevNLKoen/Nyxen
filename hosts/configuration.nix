{
  pkgs,
  config,
  aagl,
  lib,
  packages,
  ...
}: let
  systemName = config.nyxen.name;
in {
  imports = [
    aagl.nixosModules.default
  ];
  options.nyxen.name = lib.mkOption {
    type = lib.types.str;
    description = "base system name";
  };
  config = {
    nyxen.nvim.enable = true;

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
      earlyoom.enable = true;
      # Input
      xserver.xkb = {
        layout = "us";
        variant = "";
      };

      # Printing
      printing.enable = true;
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
      direnv.enable = true;
      dconf.enable = true;
      zsh.enable = true;

      git = {
        enable = true;
        config = {
          user.email = "94992822+DevNLKoen@users.noreply.github.com";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      wget
      alejandra
      nixd
      nh
      fd
      btop
      ripgrep
      zsh
      starship
      lazygit
      packages.fastfetch
    ];

    environment.sessionVariables = {
      NH_FLAKE = "github:DevNLKoen/Nyxen";
    };
  };
}
