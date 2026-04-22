{
  self,
  inputs,
  config,
  ...
}: {
  flake.nixosModules.vixusConfiguration = {pkgs, ...}: {
    imports = [
      self.nixosModules.vixusHardware
      self.nixosModules.commonConfiguration
      inputs.playit-nixos-module.nixosModules.default
    ];

    # nyxen options from modules
    nyxen = {
      name = "vixus";
    };

    services = {
      openssh.enable = true;
      playit = {
        enable = true;
        secretPath = config.age.secrets.playit-secret.path;
      };
      suwayomi-server = {
        enable = true;
        openFirewall = true;
        settings.server = {
          basicAuthEnabled = true;
          extensionRepos = ["https://raw.githubusercontent.com/yuzono/manga-repo/repo/index.min.json"];
          basicAuthUsername = "NLKoen";
          basicAuthPasswordFile = "/var/secrets/suwayomi-server-password";
        };
      };
      flaresolverr = {
        openFirewall = true;
        enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      syncyomi
    ];

    networking.firewall.allowedTCPPorts = [25565];

    systemd.sleep.settings.Sleep = {
      AllowSuspend = "no";
      AllowHibernation = "no";
      AllowHybridSleep = "no";
    };

    # Bootloader.
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

    # System info
    system.stateVersion = "26.05";
  };
}
