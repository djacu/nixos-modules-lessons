{pkgs}:
(
  pkgs.lib.evalModules {
    modules = [
      ./options.nix
      ./override.nix
    ];
  }
)
.config
