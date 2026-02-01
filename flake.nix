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

    cwc.url = "github:Cudiph/cwcwm/v0.3.0"; # the cwcwm window manager
    pinnacle.url = "github:pinnacle-comp/pinnacle";
    nix-flatpak.url = "github:/gmodena/nix-flatpak/?ref=latest";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    self,
    nixpkgs,
    wrappers,
    aagl,
    solaar,
    cwc,
    pinnacle,
    nix-flatpak,
    nvf,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    #wraps pkgs from ./pkgs
    wrap = name: import ./pkgs/${name} {inherit pkgs wrappers;};
    wrapAll =
      builtins.listToAttrs
      (
        map (name: {
          name = name;
          value = wrap name;
        })
        (builtins.attrNames (builtins.readDir ./pkgs))
      );
    packages = wrapAll // {};
  in {
    packages = packages;
    nixosConfigurations = {
      umbryn = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit self aagl cwc pinnacle packages;};

        modules = [
          ./hosts/umbryn/configuration.nix
          ./modules
          solaar.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
      vixus = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit self aagl cwc packages;};
        modules = [
          ./hosts/vixus/configuration.nix
          ./modules
          solaar.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
    };

    nvim =
      (nvf.lib.neovimConfiguration {
        pkgs = pkgs;
        modules = [./pkgs/nvim];
      }).neovim;
  };
}
