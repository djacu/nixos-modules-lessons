# Extra arguments

There will be a time when you want to pass extra arguments to your modules such as your own library or a set of packages.
This is possible with by adding attributes to `config._module.args`.

!!! note
    This mechanism is currently only [documented in the module system code][module-args], and that documentation is incomplete and out of date.

In our `options.nix` file, we declare a `greeting` option that will take `name` and create a greeting using `cowsay`.
But `pkgs` is not normally supplied automatically by the module system.
We can fix that later in our `eval.nix` file.

[//]: # (./options.nix)

In our `config.nix` we define our name per usual.

[//]: # (./config.nix)

Setup an `eval.nix` to evaluate our modules and return the `config.greeting` attribute.
However notice that we have included element in our modules list: `({...}: {config._module.args = {inherit pkgs;};})`.
This is where and how we provide a instance of nixpkgs to our modules.

[//]: # (./eval.nix)

Create a `build.sh` run script to build the `eval.nix` file.

[//]: # (./build.sh)

And if we run the script (`./build.sh`), we have our greeting in `result`.

[//]: # (build eval.nix)

[module-args]: https://github.com/NixOS/nixpkgs/blob/master/lib/modules.nix#L140-L182
