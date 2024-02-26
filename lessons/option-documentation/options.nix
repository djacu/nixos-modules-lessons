{lib, ...}: {
  options = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "A name for a user.";
      example = "Boaty McBoatface";
    };
  };
}
