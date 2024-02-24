{
  lib,
  config,
  ...
}: let
  cfg = config;
in {
  options = {
    a = lib.mkOption {
      type = lib.types.int;
    };
    b = lib.mkOption {
      type = lib.types.int;
      default = 2;
    };
    sum = lib.mkOption {
      type = lib.types.int;
    };
  };

  config = {
    sum = cfg.a + cfg.b;
  };
}
