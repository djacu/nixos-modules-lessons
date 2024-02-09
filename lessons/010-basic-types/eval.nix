let
  pkgs = import <nixpkgs> {};
  inherit (pkgs) lib;
in
  (
    pkgs.lib.evalModules {
      modules = [
        ./options.nix
        ./config.nix
      ];
    }
  )
  .config
