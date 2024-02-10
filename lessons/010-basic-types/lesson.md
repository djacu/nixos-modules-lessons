# Basic Types

In this lesson, we will cover some basic types.
There are certainly [many more types][nixos-manual-basic-types], but for this lesson, we will focus on just a few.

This example is simple and almost too trivial, but the point of this lesson is not to show something practical but illustrate basic typing.
Each option will have a specific type declared and any configuration values must be of that declared type.
For this lesson, we will not investigate setting bad config values.
We will will have declared options, a configuration that is correct, and check that our output is exactly as we expect.

In the `options.nix` file, we have declared boolean, enumeration, integer, and string options.

[//]: # (./options.nix)

In the `config.nix` file, we have declared values for all these options.

[//]: # (./config.nix)

In the `eval.nix` file, we evaluate our options and config and have it return the config values.

[//]: # (./eval.nix)

In the `run.sh` file, we evaluate the `eval.nix` file and have it print out a nicely formatted version of the configuration.

[//]: # (./run.sh)

If you execute the run file (`./run.sh`), you should see an output that matches what we have configured.

[//]: # (self.eval)

[nixos-manual-basic-types]: https://nixos.org/manual/nixos/stable/#sec-option-types
