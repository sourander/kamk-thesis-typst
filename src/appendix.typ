// Load the translations
#let lang-data = toml("lang.toml")

// Renders the "Liitteet"/"Appendices" chapter: an index listing followed by each appendix's own
// content. `items` is an array of (title: str, pages: (content, ...)); each entry in `pages` is
// rendered on its own page, numbered "Liite N i/total" instead of the normal page number.
#let render-appendices(language: "fi", items: ()) = {
  let d = lang-data.at(language)

  heading(level: 1, outlined: true, numbering: none, d.appendices_heading)

  for (i, item) in items.enumerate() {
    block(below: 0.65em)[#d.appendix #(i + 1) #item.title]
  }

  for (i, item) in items.enumerate() {
    let number = i + 1
    let total = item.pages.len()

    for (j, content) in item.pages.enumerate() {
      pagebreak(weak: true)
      set page(
        numbering: none,
        header: align(right, [#d.appendix #number #(j + 1)/#total]),
      )

      if j == 0 {
        heading(level: 1, outlined: false, numbering: none)[#d.appendix #number #item.title]
      }

      content
    }
  }
}
