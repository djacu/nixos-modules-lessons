{lib, ...}: {
  options = {
    name = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = {
    name = lib.mkDefault "Boaty McBoatface";
  };
}
