# Developer Guide

Welcome! This guide outlines the development workflow, testing procedures, and release process for the `kamk-thesis` Typst template.

## 1. Dependencies

To develop and test this package locally, you will need the following tools installed:

* [Typst](https://typst.app/) - The core typesetting system.
* [Tytanic](https://typst-community.github.io/tytanic/) - The test runner for Typst packages.
* [Just](https://just.systems/) - A command runner used for project tasks.
* [Carlito font](https://fonts.google.com/specimen/Carlito) - Required system font for the template.

## 2. Authentication Setup (Maintainers Only)

Automated releases require a GitHub Fine-Grained Personal Access Token (PAT). A token named `typst-package-token` has been created for this purpose with the following scope:

* **Target Repositories:** `sourander/typst-packages` (Only selected repositories)
* **Permissions:**
  * Contents: Read and Write
  * Metadata: Read *(GitHub default)*

**Configuration:** 
This token is stored in the main repository (`sourander/kamk-thesis-typst`) as a repository secret. It is located under **Settings > Secrets and variables > Actions** with the name `REGISTRY_TOKEN`.

## 3. Testing with Tytanic

We use Tytanic to compile test files and compare the output against reference images. 

### Adding and Running a New Test

1. **Create the test scaffold:**
   ```bash
   tt new my-test-name
   ```

2. **Write the test content:**
   Edit the newly created Typst file to define what you are testing:
   ```bash
   nano tests/my-test-name/my-test-name.typ
   ```

3. **Generate reference images:**
   Compile the test and save the output as the baseline reference in `tests/my-test-name/ref/*.png`.
   ```bash
   tt update my-test-name --use-system-fonts
   ```

4. **Run the test suite:**
   Future runs will compile `.../out/*.png` and automatically compare them against your reference images.
   ```bash
   just test
   ```

## 4. Release Workflow

When you are ready to publish a new version to Typst Universe, follow these steps strictly in order:

### Phase A: Prepare the Release
1. Implement your new features or bug fixes.
2. Run `just test` locally to ensure everything works and no visual regressions exist.
3. Push your changes to GitHub and verify that the CI/CD pipeline passes.
4. Bump the package version using Just: `just bump 1.2.3` *(replace with your target version)*.
5. Update the `CHANGELOG.md` file with detailed release notes.
6. Commit the version bump and changelog, then push to GitHub.
7. Verify the CI/CD pipeline passes one final time.

### Phase B: Tag and Publish
8. Create and push a new Git tag. This triggers the CD GitHub Action, which packages the release and pushes it to your fork (`sourander/typst-packages`).
   ```bash
   git tag -a v1.2.3 -m "Release v1.2.3"
   git push origin v1.2.3
   ```
9. Monitor the **Actions** tab in GitHub to ensure the release workflow completes successfully. *(If it fails, see the Troubleshooting section below).*

### Phase C: Submit to Typst Universe
10. Update your fork repository. Navigate to your fork on GitHub and click **Sync fork** -> **Update branch** to ensure your main branch is up to date with `typst/packages`.
11. Navigate to the **Pull requests** tab in your fork and click **New pull request**.
12. Set the PR title strictly to `kamk-thesis:1.2.3` *(matching your new version)*.
13. Use the following template for the PR description:

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
    1. The name `kamk-thesis` uses the acronym for Kajaani University of Applied Sciences (Kajaanin ammattikorkeakoulu) paired with the document type.
    2. The name complies with the naming rules because it uses an institution-specific prefix (`kamk-`), ensuring it does not squat on generic or canonical terms like `thesis` or `academic-report`.
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

## 5. Troubleshooting

### Retrying a Failed Release
If the release GitHub Action fails (e.g., due to a workflow configuration error), you will need to delete the tag, commit your fixes, and tag the release again to re-trigger the pipeline:

```bash
# 1. Delete the remote and local tags
git tag -d v1.2.3
git push --delete origin v1.2.3

# 2. (Make your fixes, commit, and push to main)

# 3. Create and push the tag again
git tag -a v1.2.3 -m "Release v1.2.3"
git push origin v1.2.3
```