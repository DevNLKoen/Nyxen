{
  description = "Nixos configuration files";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wrappers.url = "github:Lassulus/wrappers";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    aagl = {
      # an anime game launcher
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cwc.url = "github:Cudiph/cwcwm"; # the cwcwm window manager
    awww.url = "git+https://codeberg.org/LGFae/awww"; # wayland background
    nvf.url = "github:notashelf/nvf";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake
    {
      inherit inputs;
    }
    (inputs.import-tree ./modules);
}
