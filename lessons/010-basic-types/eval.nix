let
  pkgs = import <nixpkgs> {};
  inherit (pkgs) lib;
in
  #lib.generators.toPretty
  #{}
  (
    pkgs.lib.evalModules {
      modules = [
        ./options.nix
        ./config.nix
      ];
    }
  )
  .config
