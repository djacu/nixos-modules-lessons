{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    exampleNested1 = lib.mkOption {
      type = types.listOf (types.oneOf [types.str types.int types.bool]);
      description = "My example composed types.";
    };
    exampleNested2 = lib.mkOption {
      type = types.attrsOf (types.nullOr types.str);
      description = "My example composed types.";
    };
    exampleNested3 = lib.mkOption {
      type = types.attrsOf (types.listOf (types.either types.int types.str));
      description = "My example composed types.";
    };
    exampleNested4 = lib.mkOption {
      type = types.attrsOf (
        types.either
        (types.listOf (types.nullOr types.int))
        (types.attrsOf types.str)
      );
      description = "My example composed types.";
    };
  };
}
