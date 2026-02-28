{
  pkgs,
  wrappers,
  pinnacle,
}: let
  system = pkgs.stdenv.hostPlatform.system;
  configBuilder = pkgs.callPackage "${pinnacle}/nix/packages/pinnacle-config.nix" {};
  config = configBuilder {
    pname = "pinnacle-config";
    version = "0.2.2";
    src = ./config;
    cargoLock = {
      lockFile = ./config/Cargo.lock;
      allowBuiltinFetchGit = true;
    };
    postInstall = ''
      mkdir -p $out/bin
      cp -r ./* $out/bin/ 2>/dev/null || true

      substituteInPlace $out/bin/pinnacle.toml \
        --replace 'run = ["cargo", "run"]' 'run = ["./pinnacle-config"]'
    '';
  };
  server = pkgs.symlinkJoin {
    name = "pinnacle-0.2.2";
    paths = [pinnacle.packages.${system}.pinnacle];
    pname = "pinnacle";

    passthru.providedSessions = ["pinnacle"];
    meta.mainProgram = "pinnacle"; # Adjust this to "pinnacle-server" if that's the binary name
  };
in
  wrappers.lib.wrapPackage {
    inherit pkgs;
    package = server;
    args = ["-c" "${config}/bin"];
  }
