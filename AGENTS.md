# AGENTS.md

KAMK (Kajaani UAS) thesis template in Typst. No test or lint infrastructure — the verification is that `just build` compiles without errors.

## Commands

- `just build` (default) — compiles `template/thesis.typ` → `build/thesis.pdf`
- `just watch` — live recompile on change
- `just clean` — removes `build/`
- Requires `just` and `typst` CLIs.

## Structure

- `template/thesis.typ` — entry document: fills in `template.with(...)` (metadata, abstracts, keywords) and appends body chapters after it.
- `src/` — the reusable template library: `lib.typ` → `template.typ` (document skeleton, margins, ToC, page numbering), `titlepage.typ`, `abstract.typ`, `colors.typ`, `utils.typ`, and `lang.toml` (fi/en UI labels).
- `src/` is intended to be published as the Typst package `@preview/kamk-thesis:1.0.0` (see import comment in `template/thesis.typ`); until then it is imported by local relative path.
- Tip: the [typst-package-template](https://github.com/typst-community/typst-package-template) repo can be used as a reference for packaging layout (e.g. `typst.toml`, `CHANGELOG.md`, release workflow) when preparing `src/` for publication.
- Rule of thumb: template/layout changes go in `src/`; thesis content and metadata go in `template/thesis.typ`.

## Verification

- The only automated check is that `just build` compiles without errors. Run it to verify changes.
- Do NOT do any visual or rendered-output inspection. Specifically, do not render the PDF and view it, do not render PNG/PDF pages to images and analyze them, and do not attempt any visual diffing or screenshot-based checks. These pipelines are wasteful and out of scope for an agent.
- Visual inspection of the output is a human responsibility. Leave it to the user.
- Testing via the Tytanic library will be introduced later; until then, verification is manual (human inspection) plus successful compilation.

## Gotchas

- `assets/` is fully gitignored (pending marketing approval), yet `src/titlepage.typ` references `assets/cover_image.png` and `assets/KAMK_english_white_copyrighted.svg`. A fresh clone will fail to compile until those files exist locally.
- Content parameters come in `fi`/`en` pairs (title, degree, programme, keywords, abstract); the `language` param selects which labels are used for the title page, ToC, and symbol list. Adding a language means a new `src/lang.toml` section plus wiring in `template.typ`.
- The README's Calibri/Carlito font-install instructions are stale — no font is set anywhere in the current code. Do not add font configuration based on the README.
