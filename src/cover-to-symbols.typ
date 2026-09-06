#import "titlepage.typ": titlepage
#import "abstract.typ": render-abstract

// Load the translations
#let lang-data = toml("lang.toml")

#let cover-to-symbols(
  title: "",
  title-en: "",
  authors: (),
  degree-title: "",
  degree-title-en: "",
  degree-programme: "",
  degree-programme-en: "",
  keywords-fi: (),
  keywords-en: (),
  abstract-fi: none,
  abstract-en: none,
  symbols: (),
  date: datetime.today(),
  language: "fi",
  cover-image: none,
  body,
) = {
  set document(title: title, author: authors)

  // Global document settings
  set text(size: 11pt, lang: language, font: "Carlito")
  set par(justify: true, leading: 1.5em)
  
  // Render the title page with zero margins
  page(margin: 0cm)[
    #titlepage(
      title: if language == "en" { title-en } else { title },
      authors: authors,
      degree-title: degree-title,
      degree-programme: degree-programme,
      date: date,
      language: language,
      cover-image: cover-image,
    )
  ]

  /* 
    These settings apply to all pages from now on, until told otherwise.

    - Set page settings for the rest of the document
    - Set heading spacing for all headings
    - Set H1 headings to have a page break before them and a gap above them
    - Set a one-line empty gap between body text paragraphs
    */
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
  
  // Finnish abstract (Tiivistelmä)
  render-abstract(
    lang-data.at("fi"),
    authors: authors,
    language: "fi",
    title: title,
    degree: degree-title + ", " + degree-programme,
    keywords: keywords-fi,
    abstract-fi
  )
  
  pagebreak(weak: true)
  
  // English abstract (Abstract)
  render-abstract(
    lang-data.at("en"),
    authors: authors,
    language: "en",
    title: title-en,
    degree: degree-title-en + ", " + degree-programme-en,
    keywords: keywords-en,
    abstract-en
  )

  pagebreak(weak: true)

  // From now on, the headings shall be size 11 without bold
  show heading: set text(size: 11pt, weight: "regular")

// 3. Sisällys / Table of Contents
  {
    // Intercept ToC entries to format the Appendices heading specifically
    show outline.entry: it => {
      if it.element.has("label") and it.element.label == <kamk-appendices> {
        // Wrap in a block to bypass the global par(spacing: 3.0em)
        block(
          // This should follow the standard spacing within a paragraph, not between paragraphs
          above: 1.5em, 
          link(it.element.location())[#it.element.body]
        )
      } else {
        it
      }
    }

    outline(
      title: lang-data.at(language).toc,
      indent: auto,
    )
  }

  pagebreak(weak: true)

  // 4. Symboliluettelo / List of Symbols (optional)
  if symbols.len() > 0 {
    heading(level: 1, outlined: false, lang-data.at(language).symbols)
    terms(..symbols.map(pair => terms.item(pair.at(0), pair.at(1))))
    pagebreak(weak: true)
  }

  // After the ToC, we shall have numbering on the headings
  set heading(numbering: "1.1")

  // Visible page numbering only starts from the main body (e.g. "Johdanto") onwards
  set page(numbering: "1", number-align: top + right)
  counter(page).update(1)

  // Body text of the document starts here
  body
}
