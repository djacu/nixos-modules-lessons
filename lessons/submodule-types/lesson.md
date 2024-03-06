# Submodule Types

After learning about composed types, you can imagine that nesting can get deep quickly.
The logic for tracking each layer can become overwhelming.
This is where one of the most useful types included in type system comes into play: `submodule`.
It allows you to define nested modules with their own option imports, declarations, and definitions.

First we will define our submodule.
In `character.nix` we have something that looks very similar to what we built before.
We have `name`, `title`, and `origin` as inputs and a greeting that combines all these as an output.

[//]: # (./character.nix)

In our `options.nix`, we have a `characters` option that is a list of submodule that points to our `character.nix` file.
We have also defined a `greeting` option that will take all `greeting` definitions from our characters and join them into a single string.
Note: these two `greeting` options are not the same; `character.nix` and `options.nix` each have their own `greeting` option.

!!! note
    We could have written the `character.nix` submodule in place.
    For the sake of readability, we gave it its own file.
    Also, writing it in its own file allows us to use it elsewhere if desired.

[//]: # (./options.nix)

In our `config.nix`, we define all of our characters.
The behavior of the submodule type is attr-*like*.
So inside our list we have attribute sets; each one can have a value for attributes `name`, `title` and `origin`.

[//]: # (./config.nix)

Setup an `eval.nix` to evaluate our modules and return the `config.greeting` attribute.

[//]: # (./eval.nix)

Create a `run.sh` run script to evaluate the `eval.nix` file.

[//]: # (./run.sh)

And if we run the script (`./run.sh`), we have our configuration.

[//]: # (self.eval)
