# AGENTS.md

KAMK (Kajaani UAS) thesis template in Typst. The reusable template library lives in `src/`; the sample thesis document lives in `template/`.

## Commands

Run from the repo root. Requires `just` and `typst` CLIs; `tt` (Tytanic) for `just test`; `uv` for the packaging and docs recipes; the Carlito font installed for matching output.

- `just` — lists all recipes (default)
- `just build` — one-shot compile of `template/thesis.typ` → `build/thesis.pdf`; temporarily installs the library as `@preview`, compiles, then uninstalls it
- `just integration` — compiles `tests/end-to-end-fi/test.typ` → `build/integration.pdf`
- `just test [args]` — runs the Tytanic visual test suites (`tt run --use-system-fonts --no-fail-fast`)
- `just test-scripts` — runs the Python unit tests for the packaging scripts (`uv run python -m unittest discover -s scripts/tests`)
- `just thumbnail` — regenerates `thumbnail.png` (package submission thumbnail, page 1 at 150 PPI; must stay < 3 MB)
- `just skim` — opens `build/thesis.pdf` in Skim (macOS only)
- `just bump <X.Y.Z>` — updates the version in `typst.toml` and the `kamk-thesis:X.Y.Z` package references in `template/thesis.typ` and `README.md`; depends on `thumbnail`
- `just setup <target>` — print the resolved packaging configuration
- `just package <target>` — packages the library (files per `.typstignore`) into `<target>/<name>/<version>` via `scripts/install_typst_package.py`
- `just install` / `just install-preview` — package into the `@local` / `@preview` Typst package dirs of the user's data dir
- `just uninstall` / `just uninstall-preview` — remove the installed `<name>/<version>` from the `@local` / `@preview` dirs via `scripts/remove_typst_package.py`
- `just docs` — serve the Zensical docs site locally (`uvx zensical serve`)
- `template/Justfile` — a second Justfile for thesis authors working in `template/`: `just watch` (live recompile of `thesis.typ` on save) and `just draft` (one-off PDF/UA-1 build to `build/thesis-draft-YYYY-MM-DD.pdf`)

## Structure

- `template/thesis.typ` — entry document: fills in `template.frontmatter.with(...)` (metadata, abstracts, keywords) and appends body chapters from `template/chapters/` and `template/appendices/` after it; imports the library as `@preview/kamk-thesis:<version>`.
- `src/` — the reusable template library, published as `@preview/kamk-thesis` (version in `typst.toml`); entrypoint `src/lib.typ`.
  - `src/lib.typ` — public API: imports and re-exports `frontmatter`, `render-foreword`, `render-ai-usage`, `render-bibliography`, `render-appendices` from the subfolders below.
  - `src/core/` — mechanics and visual identity, independent of thesis content: `config.typ` (document setup split into `setup-document`, `setup-math`, `setup-headings`, `setup-code`, `setup-tables`, `setup-body-page`; sets the Carlito body font), `colors.typ` (KAMK brand colors), `utils.typ` (helpers like `format-authors`).
  - `src/sections/` — structural building blocks, one file per chunk of the document: `frontmatter.typ` (orchestrates title page, abstracts, ToC, symbol list, foreword), `titlepage.typ`, `abstract.typ`, `foreword.typ`, `ai-usage.typ`, `bibliography.typ`, `appendix.typ`.
  - `src/data/` — non-Typst data files: `lang.toml` (fi/en UI labels) and `kamk-vancouver.csl` (citation style), read via relative paths (e.g. `"../data/lang.toml"`) from `src/sections/*.typ`.
- `tests/` — Tytanic visual test suites: `end-to-end-fi`, `references-fi`, `titlepage-fi`.
- `docs/` — Zensical docs site (Finnish): `riippuvuudet/` (dependencies) and `syntaksi/` (syntax guides), configured by `zensical.toml` and `siteinfo.json`; built site output goes to the gitignored `site/`.
- `scripts/` — packaging tooling in Python (PEP 723 inline metadata, no dependencies, no shebangs, invoked as `uv run scripts/<name>.py`): `typst_package_config.py` (shared configuration resolver), `install_typst_package.py` and `remove_typst_package.py` (both import the config module), plus unit tests in `scripts/tests/`.
- `.github/workflows/` — `tests.yml` (script unit tests + Tytanic suites, archives the PNG outputs), `docs.yaml` (GitHub Pages deploy of the docs site), `release.yml` (on `v*` tags: builds the package via `just package out`, verifies and zips it as an artifact and pushes it to `sourander/typst-packages`).
- `.typstignore` — drives what the packager includes: one file (no subdirectory files), patterns match file/directory names from the beginning (`*` also matches `/`), last matching rule wins, and `!` rules re-include. `.git` and `.typstignore` are always excluded. Currently excludes e.g. `scripts`, `tests`, `docs`, `build`, `Justfile`, `AGENTS.md`.
- Tip: the [typst-package-template](https://github.com/typst-community/typst-package-template) repo can be used as a reference for packaging layout (e.g. `typst.toml`, `CHANGELOG.md`, release workflow) when preparing the package for publication.
- Rule of thumb: template/layout changes go in `src/`; thesis content and metadata go in `template/`.

## Verification

- `just build` must compile without errors — run it to verify changes.
- Tests are run with Tytanic (`just test`) from `tests/**/test.typ` files. Each test has `diff`, `out` and `ref` directories for the PNG images used for comparison.
- Do NOT do any visual or rendered-output inspection. Specifically, do not render the PDF and view it, do not render PNG/PDF pages to images and analyze them, and do not attempt any visual diffing or screenshot-based checks. These pipelines are wasteful and out of scope for an agent.
- Visual inspection of the output is a human responsibility. Leave it to the user.

## Gotchas

- Content parameters come in `fi`/`en` pairs (title, degree, programme, keywords, abstract); the `language` param selects which labels are used for the title page, ToC, and symbol list. Adding a language means a new `src/data/lang.toml` section plus wiring in `src/sections/frontmatter.typ`.
- The body text uses the Carlito font (set in `src/core/config.typ`); users need it installed to match KAMK's look.
- `just bump` does not update the README's `Version X.Y.Z` heading — its regex expects an HTML-escaped `&gt;Version` label, which the README no longer uses. It only updates `typst.toml` and the `kamk-thesis:X.Y.Z` package references.
- The README instructs users to run `just preview`, which does not exist in the root Justfile; the author-facing live preview is `just watch` in `template/Justfile`. Known drift.
- Package scripts write to `<target>/<name>/<version>` (name/version from `typst.toml`) and overwrite an existing same-version install.
