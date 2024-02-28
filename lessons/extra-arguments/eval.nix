{
  nixpkgs ?
    builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
      sha256 = "sha256:1vf7w61dna31ajbkwkmdxf1mizp55ym31w163l017ir8df5cgx3v";
    },
  pkgs ? import nixpkgs {},
}:
(
  pkgs.lib.evalModules {
    modules = [
      ./options.nix
      ./config.nix
      ({...}: {config._module.args = {inherit pkgs;};})
    ];
  }
)
.config
.greeting
