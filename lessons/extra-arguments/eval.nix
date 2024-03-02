{
  nixpkgs ?
    builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/tarball/aa94fc78b0a49ed2a4a69b6f5082a1b286dd392d";
      sha256 = "1gkm7r07aqiyfgr32bzjmhvgsd543m2g3m43janmb6z1hz17ks1n";
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
