nix eval -f eval-trivial.nix \
    --apply 'x: x {pkgs = import <nixpkgs> {};}' \
    --json | nix run nixpkgs#jq -- .
