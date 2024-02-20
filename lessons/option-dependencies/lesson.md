# Option dependencies

Now we have some basic knowledge of how to create an option and set its value with a config.
But previously, we created an option that was both the input and output.
What if we want several inputs and a output that is some combination of those inputs?

That is completely possible!

Options can depend on other options, making it possible to build more useful abstractions.
To make option values available to a module, the arguments of the function declaring the module must include the `config` attribute.

[//]: # (./options.nix)

As you can see, we have added `config` to the function argument of the `options.nix` module.
We have also defined `name`, `title`,  and `origin` which are all `str` types.
Those will be our inputs that will we configure.

We have also defined an option, `greeting`, which is also a `str` type.
It also has a new attribute being passed into `mkOption`, `default`.
As suggested by its name, it provides a default value for the option.

The default value in this example is a multiline string.
It will use the final configuration values of all our input options and create a little greeting for us.

!!! note
    The line `cfg = config;` is not strictly necessary.
    We could have just used the `config` argument wherever `cfg` was used.
    However, it does help mentally separate the idea of the config *argument* and the config *attribute*.
    Also, you will see more intricate uses of it throughout nixpkgs.

!!! warning
    The `config` *argument* is not the same as the `config` attribute:

    - The `config` *argument* holds the result of the module system’s lazy evaluation,
    which takes into account all modules passed to `evalModules` and their `imports`.
    - The `config` *attribute* of a module exposes that particular module’s option values to the module system for evaluation.

[//]: # (./config.nix)

[//]: # (./run.sh)
