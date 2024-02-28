{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config;
in {
  options = {
    name = lib.mkOption {
      type = lib.types.str;
    };
    greeting = lib.mkOption {
      type = lib.types.package;
    };
  };

  config = {
    greeting = let
      greet-name = pkgs.writeShellApplication {
        name = "greeting";
        runtimeInputs = [pkgs.cowsay];
        text = ''
          cowsay Hello ${cfg.name}!
        '';
      };
    in
      pkgs.runCommand
      "greeting-code-block"
      {}
      ''
        echo '```' > $out
        ${greet-name}/bin/greeting >> $out
        echo '```' >> $out
      '';
  };
}
