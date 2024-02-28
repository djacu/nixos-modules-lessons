{
  pkgs,
  lib,
  ...
}: {
  options = {
    randomPackage = lib.mkOption {
      type = lib.types.package;
      default = pkgs.hello;
      description = "A random package.";
      example = pkgs.cowsay;
    };
  };
}
