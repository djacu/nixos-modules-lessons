# Default values

Another useful attribute that can be provided to `mkOption` is `default`.
This will provide a default value for the option declaration and therefore does not *need* a definition.

Looking at the `options.nix` file, we have to options `a` and `b`, and `b` has a default value of 2.
We have an option `sum` which will take the final configuration value for `a` and `b` and add them together.

[//]: # (./options.nix)

In our `config.nix`, we only set a value for `a` and will use the default value for `b`.

[//]: # (./config.nix)

Setup an `eval.nix` to evaluate our modules and return the `config.sum` attribute.

[//]: # (./eval.nix)

Create a `run.sh` run script to evaluate the `eval.nix` file.

[//]: # (./run.sh)

And if we run the script (`./run.sh`), we should get 5.

[//]: # (self.eval)

As in many other languages, default values in the module system can be override.
In our `config-override.nix`, we set a value for `a` and `b`.

[//]: # (./config-override.nix)

Setup an `eval-override.nix` to evaluate our modules and return the `config.sum` attribute.

[//]: # (./eval-override.nix)

Create a `run-override.sh` run script to evaluate the `eval-override.nix` file.

[//]: # (./run-override.sh)

And if we run the script (`./run-override.sh`), we should get 7.

[//]: # (self.eval-override)
