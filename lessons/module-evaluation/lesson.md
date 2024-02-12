# Module Evaluation

In the [eval][eval] file, we have declared an attrset called `mymodule` which is composed of 3
fields: `imports`, `options` and `config`. This is a module with default values for those fields.
You can omit any of those fields and they will use those same default values.

[//]: # (./eval.nix)

If you execute the run file (`./run`), you will see printed the empty JSON object `{}`.

[eval]: ./eval.nix

## Module Fields

The `options` field lets you define variables that can be used in the `config` section.

The `config` field assigns values to options defined in other modules. We call this using an option.

The `imports` field lets you import other modules from a module.

We will see what goes in those fields in later lessons.

## Evaluating Modules

In the [eval][eval] file, we use a function called `evalModules`. This function takes an attrset as
argument which can contain the field named `modules`. In there, we can put as many module as we
want.

`evalModules` will then merge all `imports`, `options` and `config` fields of all given modules
following some rules we will see in the next lessons. It then produces an attrset whose only
interesting field - the result of merging all modules - is found in the `config` field. This is the
one we print when executing the `./run` file.

## Nixpkgs

The vast majority of nixpkgs is made out of modules, all merged together in the top-level
`evalModules`.

[option-types-basic]: https://nixos.org/manual/nixos/stable/#sec-option-types-basic
