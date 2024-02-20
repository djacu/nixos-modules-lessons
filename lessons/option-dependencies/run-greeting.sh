nix eval -f eval-greeting.nix \
    --apply 'x: x {pkgs = import <nixpkgs> {};}' \
    --json | nix run nixpkgs#jq -- -r
