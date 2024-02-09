let
  pkgs = import <nixpkgs> {};

  mymodule = {
    imports = [
    ];
    options = {
    };
    config = {
    };
  };
in
  (
    pkgs.lib.evalModules {
      modules = [
        mymodule
      ];
    }
  )
  .config
