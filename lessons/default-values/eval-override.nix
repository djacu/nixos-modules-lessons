{pkgs}:
(
  pkgs.lib.evalModules {
    modules = [
      ./options.nix
      ./config-override.nix
    ];
  }
)
.config
.sum
