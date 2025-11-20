{
  description = "Nixos configuration files";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wrappers.url = "github:Lassulus/wrappers";
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
    self,
    nixpkgs,
    wrappers,
    aagl,
    solaar,
    cwc,
    nix-flatpak,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    wrap = name: import ./pkgs/${name} {inherit pkgs wrappers;};
  in {
    nixosConfigurations = {
      victus16 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit aagl;
          inherit cwc;
          inherit self;
        };

        modules = [
          ./hosts/victus16/configuration.nix
          ./modules/nixos
          solaar.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
    };
    rofi = wrap "rofi";
  };
}
