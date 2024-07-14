{
  description = "BeatBridge";

  inputs = {
    nixpkgs.url = "github:nix-ocaml/nix-overlays";
    riot = {
      url = "github:dmmulroy/riot";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    serde = {
      url = "github:serde-ml/serde";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          inherit (pkgs) ocamlPackages mkShell;
          inherit (ocamlPackages) buildDunePackage;
          version = "0.0.1";
        in
        {
          devShells = {
            default = mkShell {
              buildInputs = with ocamlPackages; [
                dune_3
                ocaml
                utop
                ocamlformat
                ocaml-lsp
                uri
              ];
              inputsFrom = [
                self'.packages.default
              ];
              dontDetectOcamlConflicts = true;
            };
          };
          packages = {
            default = buildDunePackage {
              inherit version;
              pname = "beatbridge";
              buildInputs = with ocamlPackages; [
                inputs'.riot.packages.default
                inputs'.serde.packages.default
                uri
              ];
              src = ./.;
            };
          };
          formatter = pkgs.alejandra;
        };
    };
}
