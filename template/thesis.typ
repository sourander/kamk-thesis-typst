// Later, this can just be: #import "@preview/kamk-thesis:1.0.0": template
#import "../src/lib.typ": template, render-ai-usage, render-bibliography, render-appendices

// Single source of truth for the thesis language; reused by every render-* call below.
#let language = "fi"

#show: template.with(
  // Perustiedot
  authors: ("Meikäläinen Matti",),
  date: datetime.today(),
  language: language,
  // cover-image: image("my-custom-cover.jpg"), 

  // Suomenkieliset tiedot
  title: "Typst-pohjan kehittäminen Kajaanin ammattikorkeakoululle",
  degree-title: "Tradenomi (AMK)",
  degree-programme: "Tietojenkäsittely",
  keywords-fi: ("Typst", "mallipohja", "asiakirjahallinta", "AMK"),
  abstract-fi: [
    Tähän tulee opinnäytetyön suomenkielinen tiivistelmä. Typst sallii kappalejakojen tekemisen yksinkertaisesti jättämällä tyhjän rivin tekstien väliin.
    
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
  ],

  // Englanninkieliset tiedot
  title-en: "Developing a Typst Template for Kajaani University of Applied Sciences",
  degree-title-en: "Bachelor of Business Administration",
  degree-programme-en: "Business Information Technology",
  keywords-en: ("Typst", "template", "document management", "UAS"),
  abstract-en: [
    
    #lorem(50)

    #lorem(30)

    #lorem(70)
  ],

  // Symboliluettelo (valinnainen)
  symbols: (
    ("AMK", "Ammattikorkeakoulu"),
    ("API", "Application Programming Interface"),
  ),
)

/*
  Tästä alkaa opinnäytetyön varsinainen sisältö. Jokainen kappale on oma tiedostonsa, joka tuodaan tähän päädokumenttiin. Tiedostot sijaitsevat kansiossa `src/chapters/`. Kappaleiden järjestystä voi muuttaa muuttamalla tuontijärjestystä. Nämä tiedostot ja niiden sisällön kirjoittaminen on sinun tehtäväsi opinnäytetyön kirjoittajana.
*/
#include "chapters/johdanto.typ"
#include "chapters/mallipohjankayttaminen.typ"
#include "chapters/sivut.typ"

#render-ai-usage(
  language: language,
  tools: [(Syötä tiedot tähän)],
  usage: [(Kuvaa tähän, mihin tarkoitukseen ja miten tekoälyä on käytetty opinnäytetyössä ja opinnäytetyöprosessin eri vaiheissa.)],
)

#render-bibliography(language: language, source: path("references.bib"))

// Arabic page numbers stop here; appendix pages carry their own "Liite N i/total" numbering.
#set page(numbering: none)

#let appendix-items = (
  (
    title: "Sparkin asennus Windows-koneille",
    pages: (
      [#lorem(80)],
      [#lorem(60)],
    ),
  ),
  (
    title: "Toinen esimerkkiliite",
    pages: ([#lorem(40)],),
  ),
)

#render-appendices(language: language, items: appendix-items)
