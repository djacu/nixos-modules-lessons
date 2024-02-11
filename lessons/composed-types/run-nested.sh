nix eval -f eval-nested.nix --apply 'x: x {pkgs = import <nixpkgs> {};}' --json | nix run nixpkgs#jq -- .
