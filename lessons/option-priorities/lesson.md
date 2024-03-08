# Option priorities

Module options have a *priority*, represented as an integer, which determines the precedence for setting the option to a particular value.
When merging values, the priority with the lowest numeric value will be used.

When evaluating modules, the `default` attribute in `mkOption` uses `mkOptionDefault` internally to assign a priority of 1500.
There are functions that can be used to set an option definitions priority.
`mkDefault`, generally used with option definitions (i.e. `config`), has a priority of 1000.
`mkForce`, generally used when you really *really* want a value to be used, has a priority of 10.
Additionally, option definitions without a priority use `defaultOverridePriority`, which has a priority of 100.

You can use `mkOverride` to create your own option priority.
It takes two arguments: an integer as the priority followed by the option value you want to set.
Like so:

``` nix
config.some-option = mkOverride 42 false;
```

Let us take a look at using these priorities and see how they work.
In our `options.nix` file, we have a declaration and definition for the option `name`.
We are using `mkDefault`, which recall has a priority of 1000, to set the value.

[//]: # (./options.nix)

Setup an `eval.nix` to evaluate our modules and return the `config` attribute.

[//]: # (./eval.nix)

Create a `run.sh` run script to evaluate the `eval.nix` file.

[//]: # (./run.sh)

And if we run the script (`./run.sh`), we have our configuration.

[//]: # (self.eval)

This is not terribly surprising as we only had a single definition for our option.
There was only a single value that `name` could possibly be.

So what happens if we introduce another definition for `name`.
In `override.nix` we do exactly that.
Here we are setting the value for `name` directly in `config`, which recall will have a priority of 100.
We expect that this should take precedence over our original definition.

[//]: # (./override.nix)

We have a new `eval-override.nix` to evaluate our modules including the new `override.nix`.

[//]: # (./eval-override.nix)

A `run-override.sh` run script to evaluate the `eval-override.nix` file.

[//]: # (./run-override.sh)

And if we run the script (`./run-override.sh`), we have our configuration.

[//]: # (self.eval-override)

Great!
Exactly as we expected.
The lower priority value set in `override.nix` took precedence.

Let us do it again.
In `force.nix`, we introduce another definition for `name`, but we use `mkForce`.
Recall that `mkForce` has a priority value of 10.
If we merge this with our other two definitions, we expect that it should take precedence.

[//]: # (./force.nix)

We have a new `eval-force.nix` to evaluate our modules including the new `force.nix`.

[//]: # (./eval-force.nix)

A `run-force.sh` run script to evaluate the `eval-force.nix` file.

[//]: # (./run-force.sh)

And if we run the script (`./run-force.sh`), we have our configuration.

[//]: # (self.eval-force)

Great!
Again exactly as expected.
