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

* Only selected repositories: `sourander/typst-packages`
* Repository permissions:
  * Contents: Read and Write
  * Metadata: Read (*note: this is GitHub default*)

It has been added to this repository's (`sourander/kamk-thesis-typst`) secrets into `Settings > Secrets and variables > Actions` as a repository secret called `REGISTRY_TOKEN`.


## Pushing a new release

At this point, you need to do the following steps:

1. Implement the new features or bug fixes in the code.
2. Test locally using `just test` to ensure everything works as expected.
3. Push to GitHub and see that the tests pass in the CI/CD pipeline.
4. Perform a version bump with `just bump 1.2.3` (or whatever the new version is).
5. Update the `CHANGELOG.md` file.
6. Commit the changes and push to GitHub.
7. Check that the tests pass in the CI/CD pipeline again.
8. Add a new tag for the release. This will trigger the Github Action for CD. It will push the package to `sourander/typst-packages` that is a fork of `typst/packages`. 

    ```
    # After git push and checking tests, run:
    git tag -a v1.2.3 -m "Release v1.2.3"
    git push origin v1.2.3
    ```
9. Check the GitHub Actions tab to see that the release workflow has completed successfully. If it fails, you can retry the release (see below).
10. Create a Pull Request (PR) to merge the changes from the fork repository to the upstream repository, `typst/packages`. This will make the new release available in the Typst package registry. See below for instructions on how to create a PR.

### Retrying a failed release

If there would be a reason to retry after a failed tag release, one would need to:

```bash
# Delete
git tag -d v1.2.3
git push --delete origin v1.2.3

# Create again
git tag -a v1.2.3 -m "Release v1.2.3"
git push origin v1.2.3
```

## Create PR

### Updating the fork repository

To update the fork repository with the latest changes from the upstream repository, potentially quickest way is to press the **Sync fork** button on the GitHub web interface (and then press **Update branch**). This will update the fork repository with the latest changes from the upstream repository.

### Merging with the upstream repository

To start a Pull Request (PR) to merge the changes from the fork repository to the upstream repository, `typst/packages`, one can use the GitHub web interface. The steps are:

1. Go to the fork repository on GitHub.
2. Click on the **Pull requests** tab.
3. Click on the **New pull request** button.


The merge title should be simply e.g. `kamk-thesis:1.2.3` and the description should follow their given template, which is as of 2026-09-20 the following:

```markdown
<!--
Thanks for submitting a package! Please read and follow the submission guidelines detailed in the repository's README and check the boxes below. Please name your PR as `name:version` of the submitted package.

If you want to make a PR for something other than a package submission, just delete all this and make a plain PR.
-->

I am submitting
- [x] a new package
- [ ] an update for a package

<!--
Please add a brief description of your package below and explain why you think it is useful to others. If this is an update, please briefly say what changed.
-->

Description: A Typst template for formatting theses and academic documents according to the guidelines of Kajaani University of Applied Sciences (KAMK).

<!--
These things need to be checked for a new submission to be merged. If you're just submitting an update, you can delete the following section.
-->

I have read and followed the submission guidelines and, in particular, I
- [x] selected [a name](https://github.com/typst/packages/blob/main/docs/manifest.md#naming-rules) that isn't the most obvious or canonical name for what the package does
  - Explanation:
    <!--
    Please write one or two sentences explaining:
    1. The name `kamk-thesis` uses the acronym for Kajaani University of Applied Sciences (Kajaanin ammattikorkeakoulu) paired with the document type.
    2. The name complies with the naming rules because it uses an institution-specific prefix (`kamk-`), ensuring it does not squat on generic or canonical terms like `thesis` or `academic-report`.
    -->
- [x] added a [`typst.toml`](https://github.com/typst/packages/blob/main/docs/manifest.md#package-metadata) file with all required keys
- [x] added a [`README.md`](https://github.com/typst/packages/blob/main/docs/documentation.md) with documentation for my package
- [x] have chosen [a license](https://github.com/typst/packages/blob/main/docs/licensing.md) and added a `LICENSE` file or linked one in my `README.md`
- [x] tested my package locally on my system and it worked
- [x] [`exclude`d](https://github.com/typst/packages/blob/main/docs/tips.md#what-to-commit-what-to-exclude) PDFs or README images, if any, but not the LICENSE

<!--
The following box only needs to be checked for **template** submissions. If you're submitting a package that isn't a template, you can delete the following section. See the guidelines section about licenses in the README for more details.
-->
- [x] ensured that my package is licensed such that users can use and distribute the contents of its template directory without restriction, after modifying them through normal use.

```