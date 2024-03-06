{
  lib,
  options,
  config,
  ...
}: let
  cfg = config;
  opts = options;
in {
  options = {
    name = lib.mkOption {
      type = lib.types.str;
    };
    title = lib.mkOption {
      type = lib.types.str;
    };
    origin = lib.mkOption {
      type = lib.types.str;
    };

    greeting = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = {
    greeting = (
      lib.concatStringsSep
      "\n"
      (
        [
          "Hello"
        ]
        ++ (lib.optional opts.name.isDefined "My name is ${cfg.name}.")
        ++ (lib.optional opts.title.isDefined "I am a ${cfg.title}.")
        ++ (lib.optional opts.origin.isDefined "I am from ${cfg.origin}.")
      )
    );
  };
}
