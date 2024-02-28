{
  pkgs,
  lib,
  ...
}: {
  options = {
    randomPackage = lib.mkOption {
      type = lib.types.package;
      default = pkgs.hello;
      defaultText = lib.literalExpression "pkgs.hello";
      description = "A random package.";
      example = lib.literalMD "Any *random* **package**.";
    };
  };
}
