{
  description = "A collection of lessons for learning NixOS Modules.";

  nixConfig.extra-substituters = [
    "https://djacu-nixos-modules-lessons.cachix.org"
  ];
  nixConfig.extra-trusted-public-keys = [
    "djacu-nixos-modules-lessons.cachix.org-1:xvTRAYg4Wh6fagK80iDXwFDj5zL0uzSSfUr2VfesA/k="
  ];

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
      inherit (lib) fileset;
      inherit
        (poetry2nix.lib.mkPoetry2Nix {inherit pkgs;})
        mkPoetryEnv
        ;

      lessonsLib = import ./lib/lessons.nix {inherit pkgs lib;};

      site-env = mkPoetryEnv {
        projectDir = fileset.toSource {
          root = ./site;
          fileset = ./site;
        };
        python = pkgs.python311;
      };

      lessonsInfo = {
        lessonsPath = (
          fileset.toSource {
            root = ./lessons;
            fileset = ./lessons;
          }
        );
        lessonFile = "lesson.md";
      };
      lessonsDocumentation = lessonsLib.generateLessonsDocumentation lessonsInfo;

      site = pkgs.stdenvNoCC.mkDerivation {
        name = "modules-lessons-site";
        src = fileset.toSource {
          root = ./site;
          fileset = ./site;
        };
        nativeBuildInputs = [site-env];

        buildPhase = ''
          cp -r ${lessonsDocumentation}/* ./docs/
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
            lessonsDocumentation
            ;
        };

      apps = {
        copyLessonsToSite = {
          type = "app";
          program = "${lessonsLib.copyLessonsToSite}/bin/copy-lessons-to-site";
        };
      };

      checks =
        {}
        // {
          inherit
            site
            ;
        };

      inherit lessonsLib;
    });
}
