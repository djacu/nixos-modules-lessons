# Function Arguments

When you define a module as a function like we did previously, there are certain arguments that are automatically provided.
You ***do not*** have to explicitely put them in the function signature as we have the ellipsis `...` to manage any arguments we do not use.

All modules are passed the following arguments:

- `lib`: The nixpkgs library.
- `config`: The results of all options after merging the values from all modules together.
- `options`: The options declared in all modules.
- `specialArgs`: An attribute set of extra arguments to be passed to the module functions.
- All attributes of `specialArgs`.

!!! note
    The fact that all the attributes of `specialArgs` are automatically provided means you don't need to add `specialArgs` to the module function signature if we want access to `specialArgs.thing`.
    We can just add `thing` to the function signature and use it directly.

When designing a module for NixOS, there are some additional arguments that are automatically provided:

- `pkgs`: The nixpkgs package set according to the `nixpkgs.pkgs` option.
- `modulesPath`: The path to the NixOS modules directory in the nixpkgs repository.

`modulesPath` is very handy as it allows you to import extra modules from the nixpkgs package tree without having to somehow make the module aware of the location of the `nixpkgs` or NixOS directories.
It allows you to do things like this:

``` nix
{ modulesPath, ... }: {
  imports = [
    (modulesPath + "/profiles/minimal.nix")
  ];
}
```

