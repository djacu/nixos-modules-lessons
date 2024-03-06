{
  lib,
  config,
  ...
}: let
  cfg = config;
in {
  options = {
    characters = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule ./character.nix);
    };
    greeting = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = {
    greeting =
      lib.concatStringsSep
      "\n\n"
      (
        builtins.map
        (character: character.greeting)
        cfg.characters
      );
  };
}
