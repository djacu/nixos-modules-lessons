# Module Evaluation

Let us look at a basic, trivial example.
We will use the `options.nix` and `config.nix` from the previous lesson.

In the `options.nix` file, we have a single option, `name`, that is of type `str`.

[//]: # (./options.nix)

In the `config.nix` file, we have defined a value for `name`.

[//]: # (./config.nix)

What do we do now?

How do we combine these two modules together?

With a simple function, `evalModules`.

``` nix
pkgs.lib.evalModules {
  modules = [
    ./options.nix
    ./config.nix
  ];
}
```

That is it.
Provide the modules you want to evaluate in a list to the `modules` attribute.
`evalModules` will take take all the modules provided and intelligently merge them together.

If we were to run that, we would get a big messy output.
The result is a big attrset with several attributes.
For now, the attribute we care about is `config`.

In the `eval.nix` file, we take the code from above and get the `config` attribute from the evaluation.

[//]: # (./eval.nix)

In the `run.sh` file, we evaluate the `eval.nix` file and have it print out a nicely formatted version of the configuration.

[//]: # (./run.sh)

If you execute the run file (`./run.sh`), you should see an output that matches what we have configured.

[//]: # (self.eval)

