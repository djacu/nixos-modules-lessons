nix eval -f eval-override.nix \
    --apply 'x: x {pkgs = import <nixpkgs> {};}' \
    --json | nix run nixpkgs#jq -- -r
