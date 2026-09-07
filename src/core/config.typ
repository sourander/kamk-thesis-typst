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
  Page/heading defaults for everything after the (zero-margin) title page.
  Takes `body` for the same set-rule-scoping reason as setup-document.

  - Sets A4 page geometry and KAMK margins
  - Sets heading spacing for all headings
  - Sets H1 headings to have a page break before them and a gap above them
  - Sets a one-line empty gap between body text paragraphs
  - Resets heading text to non-bold 11pt (overrides the Typst default heading style)
  */
#let setup-body-page(body) = {
  set page(
    paper: "a4",
    margin: (top: 2cm, bottom: 2.5cm, left: 4.3cm, right: 1.5cm)
  )
  show heading: set block(above: 1.5em, below: 2.5em)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2.0cm)
    it
  }
  set par(spacing: 3.0em)
  show heading: set text(size: 11pt, weight: "regular")
  body
}

