{
  lib,
  config,
  ...
}: let
  cfg = config;
in {
  imports = [
    ./name.nix
    ./title.nix
    ./origin.nix
  ];

  options = {
    greeting = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = {
    greeting = ''
      Hello
      My name is ${cfg.name}.
      I am a ${cfg.title}.
      I am from ${cfg.origin}.'';
  };
}
