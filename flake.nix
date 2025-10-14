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
    cwc.url = "github:Cudiph/cwcwm"; # the cwcwm window manager
  };

  outputs = {
    nixpkgs,
    home-manager,
    aagl,
    cwc,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      Koen-Nyxen = nixpkgs.lib.nixosSystem {
        system = system;

        specialArgs = {
          inherit aagl;
          inherit cwc;
        };

        modules = [
          ./hosts/victus16/configuration.nix
          home-manager.nixosModules.home-manager
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
