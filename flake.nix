{
  description = "Nixos configuration files";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      # an anime game launcher
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    solaar = {
        url = "github:Svenum/Solaar-Flake/main";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    cwc.url = "github:Cudiph/cwcwm"; # the cwcwm window manager
    nix-flatpak.url = "github:/gmodena/nix-flatpak/?ref=latest";
  };

  outputs = {
    nixpkgs,
    home-manager,
    aagl,
    solaar,
    cwc,
    nix-flatpak,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      victus16 = nixpkgs.lib.nixosSystem {
        system = system;

        specialArgs = {
          inherit aagl;
          inherit cwc;
        };

        modules = [
          ./hosts/victus16/configuration.nix
          ./modules/nixos
          solaar.nixosModules.default
          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.nlkoen = ./home/default.nix;
            };
          }
        ];
      };
    };
  };
}
