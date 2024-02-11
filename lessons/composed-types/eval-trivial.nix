{pkgs}:
(
  pkgs.lib.evalModules {
    modules = [
      ./options-trivial.nix
      ./config-trivial.nix
    ];
  }
)
.config
