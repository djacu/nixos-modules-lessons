# Composed Types

In this lesson, we will cover some of the composed types similar to what we did in the Basic Types lesson.
There are certainly [many more composed types][nixos-manual-composed-types], but for this lesson, we will focus on just a few.

## Trivial Example

Similar to the Basic Types lesson, this first example is simple and almost too trivial.
Again, the point create simple declared options, a configuration that is correct, and check that our output is exactly as we expect.

In the `options-trivial.nix` file, we have declared multiple composed options.

[//]: # (./options-trivial.nix)

In the `config-trivial.nix` file, we have declared values for all these options.

[//]: # (./config-trivial.nix)

In the `eval-trivial.nix` file, we evaluate our options and config and have it return the config values.

[//]: # (./eval-trivial.nix)

In the `run-trivial.sh` file, we evaluate the eval file and have it print out a nicely formatted version of the configuration.

[//]: # (./run-trivial.sh)

If you execute the run file (`./run-trivial.sh`), you should see an output that matches what we have configured.

[//]: # (self.eval-trivial)

## Nested Example

Here we have a few examples with more heavily composed types.
In the `options-nested.nix` file, we have declared options with types as follows:

1. A list of any mix of strings, integers, and booleans.
1. An attribute set where the values can be either `null` or strings.
1. An attribute set where the values are lists of a mix of integers and strings.
1. An attribute set where the values are either:
    - A list of a mix of `null` values and integers.
    - An attribute set where the values are strings.

[//]: # (./options-nested.nix)

In the `config-nested.nix` file, we have declared values for all these options.

[//]: # (./config-nested.nix)

In the `eval-nested.nix` file, we evaluate our options and config and have it return the config values.

[//]: # (./eval-nested.nix)

In the `run-nested.sh` file, we evaluate the eval file and have it print out a nicely formatted version of the configuration.

[//]: # (./run-nested.sh)

If you execute the run file (`./run-nested.sh`), you should see an output that matches what we have configured.

[//]: # (self.eval-nested)

[nixos-manual-composed-types]: https://nixos.org/manual/nixos/stable/#sec-option-types-composed
