#import "/src/lib.typ" as template

// Use fixed values in regression tests.
// Do not use datetime.today(), because the output would change over time.
#let language = "fi"

#show: template.frontmatter.with(
  authors: ("Meikäläinen Matti",),
  date: datetime(
    year: 2026,
    month: 1,
    day: 15,
  ),
  language: language,

  // Suomenkieliset tiedot
  title: "Typst-pohjan kehittäminen Kajaanin ammattikorkeakoululle",
  degree-title: "Tradenomi (AMK)",
  degree-programme: "Tietojenkäsittely",
  keywords-fi: (
    "Typst",
    "mallipohja",
    "asiakirjahallinta",
    "AMK",
  ),
  abstract-fi: [
    Tämä on suomenkielisen tiivistelmäsivun regressiotesti.
    Testi varmistaa, että perustiedot, avainsanat ja tiivistelmä
    sijoittuvat asiakirjaan odotetulla tavalla.

    Toinen kappale varmistaa, että tiivistelmän kappalejako toimii.
  ],

  // Englanninkieliset tiedot
  title-en: "Developing a Typst Template for Kajaani University of Applied Sciences",
  degree-title-en: "Bachelor of Business Administration",
  degree-programme-en: "Business Information Technology",
  keywords-en: (
    "Typst",
    "template",
    "document management",
    "UAS",
  ),
  abstract-en: [
    This is a regression test for the English abstract page.
    It verifies that metadata, keywords, and abstract content
    are laid out as expected.

    The second paragraph verifies paragraph spacing.
  ],

  // Symboliluettelo
  symbols: (
    ("AMK", "Ammattikorkeakoulu"),
    ("API", "Application Programming Interface"),
  ),
)

= Johdanto

Tämä on regressiotestin varsinainen sisältö.

== Testin tarkoitus

Testi varmistaa, että suomenkielisen opinnäytetyön etuosat
renderöityvät oikein ja varsinainen sisältö alkaa odotetulla tavalla.
