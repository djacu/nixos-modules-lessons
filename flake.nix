{
  description = "LaTeX Document Demo";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    poetry2nix.url = "github:nix-community/poetry2nix";
    poetry2nix.inputs.flake-utils.follows = "flake-utils";
    poetry2nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    poetry2nix,
  }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      lib = pkgs.lib;
      inherit
        (poetry2nix.lib.mkPoetry2Nix {inherit pkgs;})
        mkPoetryEnv
        ;

      site-env = mkPoetryEnv {
        projectDir = self + /site;
        python = pkgs.python311;
      };

      site = pkgs.stdenvNoCC.mkDerivation {
        name = "modules-lessons-site";
        src = self + "/site";
        nativeBuildInputs = [site-env];

        buildPhase = ''
          mkdir -p .cache/plugin/social
          cp ${pkgs.roboto}/share/fonts/truetype/Roboto-* .cache/plugin/social/
          mkdocs build --site-dir dist
        '';
        installPhase = ''
          mkdir $out
          cp -R dist/* $out/
        '';
      };
    in {
      devShells = {
        poetry = pkgs.mkShell {
          packages = [
            pkgs.poetry
            pkgs.python311
          ];
        };
        site = pkgs.mkShell {
          buildInputs = [
            pkgs.poetry
            site-env
          ];
        };
      };
      packages =
        {
        }
        // {
          inherit
            site
            ;
        };

      checks =
        {}
        // {
          inherit
            site
            ;
        };
    });
}
