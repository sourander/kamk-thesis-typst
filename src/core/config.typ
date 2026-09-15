#import "colors.typ": code-block-bg

// Document-wide defaults: metadata, base text/paragraph style. Applied once, at the very start.
// Takes `body` so the set/show rules stay in scope for the rest of the document, since Typst
// scopes them to the block they're defined in rather than leaking into the caller.
#let setup-document(title: "", authors: (), language: "fi", body) = {
  set document(title: title, author: authors)
  set text(size: 11pt, lang: language, font: "Carlito")
  set par(justify: true, leading: 1.5em)
  body
}

/*
  Equation numbering defaults, kept separate from setup-body-page so it can be
  applied and tested on its own (see tests/math-fi).
  Takes `body` for the same set-rule-scoping reason as setup-document.

  - Uses Typst's built-in equation numbering (no custom counters/layout)
  - Wraps the number in parentheses, e.g. "(1)", per KAMK conventions
  - Uses the localized "Kaava"/"Equation" supplement instead of Typst's default "Equation"
  */
#let setup-math(language: "fi", body) = {
  let lang-data = toml("../data/lang.toml")
  set math.equation(numbering: "(1)", supplement: lang-data.at(language).equation)
  body
}

/*
  Heading reference supplement, kept separate so it can be applied and tested
  on its own (see tests/ch-labels-fi). Takes `body` for the same set-rule-scoping
  reason as setup-document.

  - Uses the localized "Luku"/"Chapter" supplement for heading references
  - Heading numbering itself (e.g. "1.1") is enabled later, once the ToC has
    been rendered (see frontmatter.typ), so a reference reads as "Luku 2.3"
  */
#let setup-headings(language: "fi", body) = {
  let lang-data = toml("../data/lang.toml")
  set heading(supplement: lang-data.at(language).chapter)
  body
}

/*
  Page/heading defaults for everything after the (zero-margin) title page.
  Takes `body` for the same set-rule-scoping reason as setup-document.

  - Sets A4 page geometry and KAMK margins
  - Sets heading spacing for all headings
  - Sets H1 headings to have a page break before them and a gap above them
  - Sets a one-line empty gap between body text paragraphs
  - Resets heading text to non-bold 11pt (overrides the Typst default heading style)
  - Applies the parenthesized equation numbering from setup-math
  - Applies the localized chapter/heading reference supplement from setup-headings
  */
#let setup-body-page(language: "fi", body) = {
  set page(
    paper: "a4",
    margin: (top: 2cm, bottom: 2.5cm, left: 4.3cm, right: 1.5cm)
  )
  show heading: set block(above: 3.0em, below: 2.0em)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }

  set par(spacing: 3.0em)
  show heading: set text(size: 11pt, weight: "regular")
  setup-headings(language: language, setup-math(language: language, body))
}

/*
  Renders a code listing as a figure, with automatic short/long-form behaviour
  based on line count:

  - Short (< 10 lines): no line numbers, no caption.
  - Long (>= 10 lines): line numbers, caption is required.

  Both forms get a light-grey, full-text-width background. An `alt`
  description is accepted but optional.

  Short blocks use a dedicated, un-numbered figure kind so they don't consume
  a slot in the long-block numbering sequence (which would otherwise leave
  gaps in the visible "Koodi N" / "Code N" captions).

  `code` must be a raw element (i.e. a fenced ```lang ... ``` block), since its
  `.text` field is inspected to count lines automatically.
*/
#let code-block(
  alt: none,
  caption: none,
  language: "fi",
  code,
) = {
  let lang-data = toml("../data/lang.toml")

  let is-long = code.text.split("\n").len() >= 10

  if is-long {
    assert(
      caption != none,
      message: "code-block: >= 10 rivin koodilohko vaatii kuvatekstin (caption).",
    )
  }

let styled-code = {
  // Set the code font and size.
  show raw.where(block: true): set text(
    // font: "DejaVu Sans Mono",
    size: 10pt,
  )

  // Control the line spacing within a code block.
  show raw.where(block: true): set par(leading: 0.75em)

  show raw.line: line => {
    if is-long {
      box(width: 1.25em)[
        #align(
          right,
          text(
            // font: "DejaVu Sans Mono",
            size: 10pt,
            fill: gray,
            str(line.number),
          ),
        )
      ] + h(1.5em) + line.body
    } else {
      line
    }
  }

  block(
    width: 100%,
    fill: code-block-bg,
    inset: 1em,
    radius: 4pt,
    breakable: true,
  )[
    #align(left)[
      #code
    ]
  ]
}

  if is-long {
    figure(
      styled-code,
      caption: caption,
      alt: alt,
      kind: raw,
      supplement: lang-data.at(language).code,
      numbering: "1",
    )
  } else {
    figure(
      block(width: 100%)[
        #grid(
          columns: (1fr, auto),
          column-gutter: 1em,
          align: (left, right + horizon),
          styled-code,
          context counter(
            figure.where(kind: raw)
          ).display("(1)"),
        )
      ],
      alt: alt,
      kind: raw,
      supplement: lang-data.at(language).code,
      numbering: "1",
      outlined: false,
    )
  }
}
