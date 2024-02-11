{pkgs}:
(
  pkgs.lib.evalModules {
    modules = [
      ./options-nested.nix
      ./config-nested.nix
    ];
  }
)
.config
