{lib, ...}: {
  options = {
    origin = lib.mkOption {
      type = lib.types.str;
    };
  };
}
