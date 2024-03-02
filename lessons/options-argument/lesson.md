# Options argument

There is another attribute that is automatically provided by the  module system, `options`.
`options` provides information about all of the option declarations in the module.
It has much more information than `config` which only gives you the final value.
It can tell you what the type is, what the default value is, whether or not it is defined, and many more things.

!!! note
    This is the `options` function argument attribute which is not to be confused by the `options` attribute where we declare options.

Let us take a look at using the information provided by `options` to create conditional logic.
In our `options.nix` file, we have the same option declarations that we have seen in previous lessons.
However, we have change how `greeting` is defined.
Now the definition is conditionally generated depending on which options we define.
If we set a value for `name`, then we will get an additional line in our output.
If we do not, then that line is completely omitted.

[//]: # (./options.nix)

In our `config.nix`, we define values for `name` and `origin`, but not `title`.
This is fine because use of the title definition is contingent on whether or not it is defined—remember nix is *lazy*!

[//]: # (./config.nix)

Setup an `eval.nix` to evaluate our modules and return the `config.greeting` attribute.

[//]: # (./eval.nix)

Create a `run.sh` run script to evaluate the `eval.nix` file.

[//]: # (./run.sh)

And if we run the script (`./run.sh`), we have our configuration.

[//]: # (self.eval)
