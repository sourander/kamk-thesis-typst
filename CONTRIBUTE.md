# Developer guide

This guide is currently in draft/scratch/memo phase. It will include things like:

Dependencies: 

* [Typst](https://typst.app/)
* [Tytanic](https://typst-community.github.io/tytanic/)
* [Just](https://just.systems/)
* [Carlito font](https://fonts.google.com/specimen/Carlito)

Also, I will need to explain the Tytanic inner workings, and how to run the tests. Like, adding a new test would be:

```bash
# Create new test
tt new my-test-name

# Define what is in the test file
nano tests/my-test-name/my-test-name.typ

# Update tests/my-test-name/ref/*.png
tt update my-test-name --use-system-fonts

# Now on, the test will generate .../out/*.png and compare those pictures
just test
```

Then, you can add your test files to the `tests/my-test-name` folder. The test will be run automatically when you run `just test`.

## Token

This repository requires a GitHub Fine-Grained PAT (Personal Access Token). For this, a token called `typst-package-token` has been created. It has the following permissions:

* Only selected repositories: `kamk-thesis-typst`
* Repository permissions:
  * Contents: Read and Write
  * Metadata: Read (*note: this is GitHub default*)

It has been added to this repository's (`sourander/kamk-thesis-typst`) secrets into `Settings > Secrets and variables > Actions` as a repository secret called `REGISTRY_TOKEN`.
