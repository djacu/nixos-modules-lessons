# Documentation functions

The documentation produced from the available functions is acceptable but what happens when a default value or example is a package?
Let us take a look by creating a new option in our `options.nix` file called `randomPackage`.

[//]: # (./options.nix)

As before, we have a `docs.nix` file to create the CommonMark documentation.

[//]: # (./docs.nix)

We have a `build-docs.sh` script to help us build the docs.

[//]: # (./build-docs.sh)

If we run the script, we will produce an output in `result` that renders as follows.

---

[//]: # (build docs.nix)

---

That is not great.
The default and example values refernece the derivations for those packages.
However, we have some tools to help us produce better documentation.

Within `mkOption`, there is another attribute we can use `defaultText` which will replace `default` in the documentation.
This nicely separates `default` which is used for module evaluation from what appears in the documentation.
Example has no alternative value because it is purely used for documentation.

In addtion, we have two functions: `literalExpression` and `literalMD`.

`literalExpression` causes the given string to be rendered verbatim in the documentation as Nix code.
This is necessary for complex values, e.g. functions, or values that depend on other values or packages.
You could write in `"pkgs.hello"` but then the documention would render with the double quotes implying that it is a string.
Rather if we pass that string to `literalExpression`, the quotes are removed and the documentation renders it as code.

`literalMD` causes the given markdown text to be inserted verbatim in the documentation, for when a `literalExpression` would be too hard to read.

Examine our new `options-fixed.nix` file to see how we have implemented all of these new features to improve our module.

[//]: # (./options-fixed.nix)

We have a new `docs-fixed.nix` file to create the CommonMark documentation.

[//]: # (./docs-fixed.nix)

We have a `build-docs-fixed.sh` script to help us build the docs.

[//]: # (./build-docs-fixed.sh)

If we run the script, we will produce an output in `result` that renders as follows.

---

[//]: # (build docs-fixed.nix)

---

Much better!
