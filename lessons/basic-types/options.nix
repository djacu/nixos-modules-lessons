{lib, ...}: let
  inherit (lib) types;
in {
  options = {
    exBool = lib.mkOption {
      type = types.bool;
      description = "My example boolean.";
    };
    exEnum = lib.mkOption {
      type = types.enum ["left" "right"];
      description = "My example enumeration.";
    };
    exInt = lib.mkOption {
      type = types.int;
      description = "My example integer.";
    };
    exStr = lib.mkOption {
      type = types.str;
      description = "My example string.";
    };
  };
}
