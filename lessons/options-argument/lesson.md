# Options argument

There is another attribute that is automatically provided by the  module system, `options`.
Options 

!!! note
    This is the `options` function argument attribute which is not to be confused by the `options` attribute where we declare options.

[//]: # (./options.nix)

[//]: # (./config.nix)

Setup an `eval.nix` to evaluate our modules and return the `config.greeting` attribute.

[//]: # (./eval.nix)

Create a `run.sh` run script to evalute the `eval.nix` file.

[//]: # (./run.sh)

And if we run the script (`./run.sh`), we have our configuration.

[//]: # (self.eval)
