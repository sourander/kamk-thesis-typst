# The `kamk-thesis` Package
<div align="center">Version 0.1.0</div>

A Typst template for theses at Kajaani University of Applied Sciences (KAMK): title page, Finnish and English abstracts, table of contents, optional list of symbols, and body chapters with KAMK's official page geometry and automatic page numbering.

## Getting Started

These instructions will get you a copy of the project up and running locally. [`template/thesis.typ`](template/thesis.typ) is a ready-made entry document you can copy and fill in with your thesis content.

```typ
#import "@preview/kamk-thesis:0.1.0" as template

#show: template.frontmatter.with(
  // Perustiedot
  authors: ("Meikäläinen Matti",),
  date: datetime.today(),
  // Other parameters removed for brevity; see the thesis.typ for full example
  // ...
)

// ...

// Body chapters are included from separate files, e.g.:
#include "chapters/johdanto.typ"
#include "chapters/mallipohjankayttaminen.typ"
#include "chapters/sivut.typ"

// ...
```

### Installation

Prerequisites: the [`typst`](https://typst.app/docs/) and [`just`](https://github.com/casey/just) CLIs.

```
$ git clone https://github.com/sourander/kamk-thesis-typst
$ cd kamk-thesis-typst
$ just build   # compiles template/thesis.typ → build/thesis.pdf
```

## Font installation

The template uses the **Carlito** font for body text. It ships with Windows as a fallback for the proprietary Calibri, but Linux and macOS users need to install it to match KAMK's look.

### On Ubuntu

Follow these steps to install Carlito on Ubuntu:

1. Open your Terminal (`Ctrl` + `Alt` + `T`).
2. Update your package list and install the font by running:
   ```bash
   sudo apt update && sudo apt install fonts-crosextra-carlito
    ```
3. Update the font cache by running:
   ```bash
   fc-cache -f -v
   ```

### On macOS

Follow these steps to install Carlito on macOS:

```bash
brew install --cask font-carlito
``` 

## Usage

`template` renders the full front matter (title page, Tiivistelmä, Abstract, Sisällys, optional symbol list) followed by your body content, with A4 paper, KAMK margins, and heading/page-numbering rules applied automatically. All content parameters come in `fi`/`en` pairs; the `language` parameter selects which labels are used for the title page, table of contents, and symbol list.

Template arguments:

- `title` / `title-en` — thesis title
- `authors` — tuple of author names
- `degree-title` / `degree-title-en` — e.g. "Tradenomi (AMK)"
- `degree-programme` / `degree-programme-en` — e.g. "Tietojenkäsittely"
- `keywords-fi` / `keywords-en` — tuples of keywords
- `abstract-fi` / `abstract-en` — abstract content
- `symbols` — optional list of `(abbreviation, expansion)` pairs, rendered as a list of symbols
- `date` — defaults to today
- `language` — `"fi"` or `"en"`
- `cover-image` — optional image overriding the default KAMK cover
- `body` — the thesis chapters

A complete worked example lives in [`template/thesis.typ`](template/thesis.typ).

## Acknowledgments

- Heavily inspired by the [WUT diploma thesis template](https://github.com/fuine/wut-thesis-typst) by Warsaw University of Technology in how the files are organized and named.
- Released under the [MIT No Attribution License](LICENSE).
