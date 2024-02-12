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

Note that our option declarations and option definitions do not need to exist in the same file.
When we evaluate our modules, we can simply include both files.
As long as every definition has a declaration, we can successfully evaluate our modules.
If there is an option definition that has not been declared, the module system will throw an error.

## Function Arguments

### FIXME: Talk about the automatically provided arguments

[option-types-basic]: https://nixos.org/manual/nixos/stable/#sec-option-types-basic
