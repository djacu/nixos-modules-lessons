# Basic Types

In this lesson, we will cover some basic types.
There are certainly [many more types][nixos-manual-basic-types], but for this lesson, we will focus on just a few.

Notice in the [options][options] file, we have declared boolean, enumeration, integer, and string options.

[//]: # (./options.nix)

Notice in the [config][config] file, we have declared values for all these options.

[//]: # (./config.nix)

If you execute the run file (`./run`), you should see an output that matches what we have configured.

[nixos-manual-basic-types]: https://nixos.org/manual/nixos/stable/#sec-option-types
[options]: ./options.nix
[config]: ./config.nix
