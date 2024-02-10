{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    exampleListOf = lib.mkOption {
      type = types.listOf types.int;
      description = "My example list of integers.";
    };
    exampleAttrsOf = lib.mkOption {
      type = types.attrsOf types.str;
      description = "My example attrs of strings.";
    };
    exampleNullOr = lib.mkOption {
      type = types.nullOr types.bool;
      description = "My example null or boolean.";
    };
    exampleEither = lib.mkOption {
      type = types.either types.str types.int;
      description = "My example either string or integer.";
    };
    exampleOneOf = lib.mkOption {
      type = types.oneOf [types.str types.int types.bool];
      description = "My example one of string, integer, or bool.";
    };
  };
}
