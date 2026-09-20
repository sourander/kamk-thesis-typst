# The `kamk-thesis` Package
<div align="center">Version 0.0.1</div>

A Typst template for theses at Kajaani University of Applied Sciences (KAMK): title page, Finnish and English abstracts, table of contents, optional list of symbols, and body chapters with KAMK's official page geometry and automatic page numbering.

## Getting Started

### Installation

Prerequisites: the [`typst`](https://typst.app/docs/) and [`just`](https://github.com/casey/just) CLIs.

```
typst install @preview/kamk-thesis:0.0.1
```

### Usage

After installation, you need to modify the `thesis.typ` file to include your own content. Below is a minified example of what the file contains. The `#show` block is where you define the front matter parameters, and the `#include` statements are where you include your body chapters.

```typ
#import "@preview/kamk-thesis:0.0.1" as template

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

// ... AI usage declaration, bibliography and appendices follow, see the thesis.typ for full example.
```

### Previewing your thesis

When you want to see a preview of your thesis, run the following `Justfile` command in the terminal. It will create a `build/thesis.pdf` file with your thesis content and keep the file updated as you edit your source files. You may exit this mode with `Ctrl` + `C` when you are done.

```
just preview
```

See the Zesical-generated documentation at [https://sourander.github.io/kamk-thesis-typst/](https://sourander.github.io/kamk-thesis-typst/) for more usage examples, video tutorials and so on.

## Font installation

The template uses the **Carlito** font for body text. Installation is guide at the [Zensical docs site](https://sourander.github.io/kamk-thesis-typst/riippuvuudet/). Compilation will fail without the font installed.

## Usage

`template` renders the full front matter (title page, Tiivistelmä, Abstract, Sisällys, optional symbol list) followed by your body content, with A4 paper, KAMK margins, and heading/page-numbering rules applied automatically. All content parameters come in `fi`/`en` pairs; the `language` parameter selects which labels are used for the title page, table of contents, and symbol list. A complete worked example lives in [`template/thesis.typ`](template/thesis.typ).

For more usage examples, see the Zensical-generated documentation at [https://sourander.github.io/kamk-thesis-typst/](https://sourander.github.io/kamk-thesis-typst/).

## Problems and Contributing

For any problems, please contact the key maintainer, Jani Sourander. You should be KAMK's student if you are reading this. Use KAMK's internal communication channels to reach out to me.

For contributing, see the original repository and the included contribution markdown file.

## Acknowledgments

- Heavily inspired by the [WUT diploma thesis template](https://github.com/fuine/wut-thesis-typst) by Warsaw University of Technology in how the files are organized and named.
- Source code released under the [MIT No Attribution License](LICENSE).
- IMPORTANT! The project contains KAMK logo and design choices that are the property of Kajaani University of Applied Sciences Oy.

