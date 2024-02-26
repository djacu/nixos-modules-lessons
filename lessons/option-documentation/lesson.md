# Option documentation

As you start creating option declarations, it is important to document them.
In addition to `type` and `default`, there are two other attributes available that will appear in generated documentation, `description` and `example`.

In `options.nix`, we have a option declared, `name`, and we have set the attributes for `description` and `example`.

[//]: # (./options.nix)

To generate documentation, we will use another function from nixpkgs, `nixosOptionsDoc`.
In `docs.nix`, we evaluate our modules with `evalModules` as we have done previously.
That is passed to the `nixosOptionsDoc` function as the `options` attribute.
`nixosOptionsDoc` produces documentation in many forms: JSON, AsciiDoc, and CommonMark.
For this lesson, we will look at CommonMark.

[//]: # (./docs.nix)

We have a `build-docs.sh` script to help us build the docs.

[//]: # (./build-docs.sh)

If we run the script, we will produce an output in `result` that renders as follows.

---

[//]: # (build docs.nix)

---
