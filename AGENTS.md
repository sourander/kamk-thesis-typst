# AGENTS.md

KAMK (Kajaani UAS) thesis template in Typst. No test or lint infrastructure — the verification is that `just build` compiles without errors.

## Commands

- `just build` (default) — compiles `template/thesis.typ` → `build/thesis.pdf` (PDF/A-1a)
- `just watch` — live recompile on change
- `just clean` — removes `build/`
- `just skim` — opens `build/thesis.pdf` in Skim (macOS only)
- Requires `just` and `typst` CLIs.

## Structure

- `template/thesis.typ` — entry document: fills in `template.frontmatter.with(...)` (metadata, abstracts, keywords) and appends body chapters after it.
- `src/` — the reusable template library, published eventually as `@preview/kamk-thesis:1.0.0` (see import comment in `template/thesis.typ`); until then it is imported by local relative path from `src/lib.typ`.
  - `src/lib.typ` — public API: imports and re-exports `frontmatter`, `render-ai-usage`, `render-bibliography`, `render-appendices` from the subfolders below.
  - `src/core/` — mechanics and visual identity, independent of thesis content: `config.typ` (page/text/heading defaults, extracted into `setup-document`/`setup-body-page`; sets the Carlito body font), `colors.typ` (KAMK brand colors), `utils.typ` (helpers like `format-authors`).
  - `src/sections/` — structural building blocks, one file per chunk of the document: `frontmatter.typ` (orchestrates title page, abstracts, ToC, symbol list — the old `cover-to-symbols.typ`), `titlepage.typ`, `abstract.typ`, `ai-usage.typ`, `bibliography.typ`, `appendix.typ`.
  - `src/data/` — non-Typst data files: `lang.toml` (fi/en UI labels) and `kamk-vancouver.csl` (citation style), read via relative paths (e.g. `"../data/lang.toml"`) from `src/sections/*.typ`.
- Tip: the [typst-package-template](https://github.com/typst-community/typst-package-template) repo can be used as a reference for packaging layout (e.g. `typst.toml`, `CHANGELOG.md`, release workflow) when preparing `src/` for publication.
- Rule of thumb: template/layout changes go in `src/`; thesis content and metadata go in `template/thesis.typ`.

## Verification

- The only automated check is that `just build` compiles without errors. Run it to verify changes.
- Do NOT do any visual or rendered-output inspection. Specifically, do not render the PDF and view it, do not render PNG/PDF pages to images and analyze them, and do not attempt any visual diffing or screenshot-based checks. These pipelines are wasteful and out of scope for an agent.
- Visual inspection of the output is a human responsibility. Leave it to the user.
- Testing via the Tytanic library will be introduced later; until then, verification is manual (human inspection) plus successful compilation.

## Gotchas

- `assets/` is fully gitignored (pending marketing approval), yet `src/sections/titlepage.typ` references `assets/cover_image.jpg` and `assets/KAMK_english_white_copyrighted.svg` (via `../../assets/...`, since `sections/` is nested one level deeper than the old flat `src/`). A fresh clone will fail to compile until those files exist locally.
- Content parameters come in `fi`/`en` pairs (title, degree, programme, keywords, abstract); the `language` param selects which labels are used for the title page, ToC, and symbol list. Adding a language means a new `src/data/lang.toml` section plus wiring in `src/sections/frontmatter.typ`.
- The body text uses the Carlito font (set in `src/core/config.typ`); users need it installed to match KAMK's look. The README currently has no font-install guide for Windows. Using Calibri as fallback is being considered, but not decided.
- The README also still shows an older `#import "../src/lib.typ": template` / `template.with(...)` usage snippet; the actual exported entry point is `template.frontmatter.with(...)` (see `template/thesis.typ` for the working example). This drift predates the `core`/`sections`/`data` split and hasn't been fixed yet.
