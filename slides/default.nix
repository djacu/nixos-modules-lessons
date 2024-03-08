{
  pkgs,
  parentPath,
}: let
  inherit (pkgs) lib;

  markdowns = (
    builtins.removeAttrs
    (builtins.readDir parentPath)
    ["default.nix"]
  );

  md2slides = name: _: (
    let
      slide-name = "slides-" + (lib.removeSuffix ".md" name);
      filepath = (builtins.toString parentPath) + "/" + name;
    in
      (builtins.trace filepath)
      lib.nameValuePair
      slide-name
      (
        pkgs.writeShellApplication
        {
          name = slide-name;
          runtimeInputs = [pkgs.reveal-md];
          text = ''
            reveal-md ${filepath}
          '';
        }
      )
  );

  slides =
    lib.mapAttrs'
    md2slides
    markdowns;
in
  slides
