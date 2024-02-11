# What is a module

In this lesson, we will cover:

- what a module is
- ***FIXME***

## Structure

### An empty module

Modules have the following basic structure.

```nix title="useless.nix"
{...}: {
}
```

This, as the filename suggests, is completely useless.
It takes no arguments and returns an empty attrset.
However, it does evaluate.
So when we look at the following examples, keep in mind that everything we add is optional.

### A basic module

Let us look at a more practical setup.

```nix title="default.nix"
{lib, ...}: {
  imports = [
    ./relative/path/to/another/module.nix
    /absolute/path/to/another/module.nix
  ];
  options = {
    # declarations of options
    };
  };
  config = {
    # configuration of options
  };
}
```

!!! note
    `options` and `config` and have formal names —
    that is ***option declarations*** and ***option definitions*** respectively.
    The rest of these lessons will use them interchangeably.

#### function argument

Now the module is a function which takes *at least* one argument, `lib`,
and may accept other arguments (expressed by the ellipsis `...`).
This will make Nixpkgs library functions available within the function body.

!!! note
    The ellipsis `...` is necessary because arbitrary arguments can be passed to modules.
    Every module you create that is a function, should have this.

    The `lib` argument is passed automatically by the module system.
    It is absolutely vital for modules that have option declarations, as you will need `lib` for defining options and their types.
    It is one of several arguments that are automatically provided by the module system.
    The full list of arguments is discussed later.

#### imports

This imports list enumerates the paths to other NixOS modules.
This is a useful mechanism for breaking up modules into small components and importing what you need.

#### options

To set any values, the module system first has to know which ones are allowed.

This is done by declaring options that specify which values can be set and used elsewhere.
Options are declared by adding an attribute under the top-level `options` attribute.
The most general way to declare an option is using `lib.mkOption`.

``` nix title="options.nix"
{lib, ...}: {
  options = {
    name = lib.mkOption {
      type = lib.types.str;
    };
  };
}
```

While many attributes for customizing options are available,
the most important one is `type`,
which specifies which values are valid for an option.
There are several types available under [`lib.types`][option-types-basic] in the Nixpkgs library.

Here we have declared an option `name` with the `str` type.
This specifies that the only valid value is a string and can only be a single definition.

#### config

Option definitions are generally straight-forward bindings of values to option names.

``` nix title="config.nix"
{
  config.name = "Boaty McBoatface";
}
```

## Function Arguments

### FIXME: Talk about the automatically provided arguments

## Evaluation

### FIXME: Talk about evalModules

Note that our option declarations and option definitions do not need to exist in the same file.
When we evaluate our modules, we can simply include both files.
As long as every definition has a declaration, we can successfully evaluate our modules.
If there is an option definition that has not been declared, the module system will throw an error.

# ***OLD***

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
