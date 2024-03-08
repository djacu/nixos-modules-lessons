nix eval -f eval-force.nix \
    --apply 'x: x {pkgs = import <nixpkgs> {};}' \
    --json | nix run nixpkgs#jq -- -r
