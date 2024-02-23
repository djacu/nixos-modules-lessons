# Splitting Modules

Based on what we have covered so far, you can imagine that a module can get quite large.
You could also imagine having several independent modules with some common option declarations.
It would be ideal if it were possible to split modules apart into component pieces.

That is possible with another top level module attribute, `imports`.

Using the same setup from the previous lesson, let us separate the `name`, `title`, and `origin` option declarations into their own modules.

[//]: # (./name.nix)

[//]: # (./title.nix)

[//]: # (./origin.nix)

In our `options.nix` file, we import them as using `imports` which takes a list of paths.
This is equivalent to if we had declared all of these options in the `options.nix` file.

[//]: # (./options.nix)

Our configuration is the same; we define values for `name`, `title`, and `origin`.

[//]: # (./config.nix)

Setup an `eval.nix` to evaluate our modules and return the `config.greeting` attribute.

[//]: # (./eval.nix)

Create a `run.sh` run script to evaluate the `eval.nix` file.

[//]: # (./run.sh)

And if we run the script (`./run.sh`), we have our configuration.

[//]: # (self.eval)
