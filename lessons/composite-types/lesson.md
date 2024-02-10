# Composite Types

In this lesson, we will cover some of the composed types similar to what we did in the Basic Types lesson.
There are certainly [many more composed types][nixos-manual-composed-types], but for this lesson, we will focus on just a few.

## Trivial Example

Similar to the Basic Types lesson, this first example is simple and almost too trivial.
Again, the point create simple declared options, a configuration that is correct, and check that our output is exactly as we expect.

In the options file, we have declared multiple composed options.

[//]: # (./options-trivial.nix)

In the config file, we have declared values for all these options.

[//]: # (./config-trivial.nix)

In the eval file, we evaluate our options and config and have it return the config values.

[//]: # (./eval-trivial.nix)

In the run file, we evaluate the eval file and have it print out a nicely formatted version of the configuration.

[//]: # (./run-trivial.sh)

If you execute the run file (`./run-trivial.sh`), you should see an output that matches what we have configured.

[//]: # (self.eval-trivial)

[nixos-manual-composed-types]: https://nixos.org/manual/nixos/stable/#sec-option-types-composed
