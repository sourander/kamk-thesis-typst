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
  title: "Integraatiotesti: kaikki kaikesta",
  degree-title: "Tradenomi (AMK)",
  degree-programme: "Tietojenkäsittely",
  keywords-fi: (
    "lorem",
    "ipsum",
    "dolor",
    "sit",
  ),
  abstract-fi: [
    Tämä on suomenkielisen tiivistelmäsivun regressiotesti.
    Testi varmistaa, että perustiedot, avainsanat ja tiivistelmä
    sijoittuvat asiakirjaan odotetulla tavalla.

    Toinen kappale varmistaa, että tiivistelmän kappalejako toimii.
  ],

  // Englanninkieliset tiedot
  title-en: "Integration test: everything about everything",
  degree-title-en: "Bachelor of Business Administration",
  degree-programme-en: "Business Information Technology",
  keywords-en: (
    "amet",
    "consectetur",
    "adipiscing",
    "elit",
  ),
  abstract-en: [
    This is a regression test for the English abstract page.
    It verifies that metadata, keywords, and abstract content
    are laid out as expected.

    The second paragraph verifies paragraph spacing.
  ],

  // Alkusanat
  foreword: [
    #lorem(75)

    #lorem(50)

    #lorem(80)
  ],

  // Symboliluettelo
  symbols: (
    ("LOREM", lorem(25)),
    ("Ipsum", lorem(15)),
    ("Dolor", lorem(10)),
    ("Sit amet", lorem(30)),
  ),
)

= Johdanto

#lorem(100)

#lorem(50)

#lorem(130)

= Feikki luku


== Matikka

#lorem(50)

Inline-matematiikka toimii ilman erillistä numerointia: $a^2 + b^2 = c^2$. Lohkotason yhtälö saa juoksevan numeron sulkeissa (ks. @math-fi-quadratic, aivan oikea laita sivua).

#math.equation(
  alt: "x on yhtä kuin miinus b plus tai miinus neliöjuuri b toiseen
  miinus neljä a c, jaettuna kahdella a:lla",
  block: true,
  $ x = (-b plus.minus sqrt(b^2 - 4a c)) / (2a) $,
) <math-fi-quadratic>

#lorem(50). Toinen numeroitu yhtälö, jotta juokseva numerointi voidaan tarkistaa, on alla (ks. @math-fi-energy).

#math.equation(
  alt: "E on yhtä kuin m kertaa c toiseen",
  block: true,
  $ E = m c^2 $,
) <math-fi-energy>

Kertauksena vielä, että yhtälöihin voi viitata numeroiden sijaan label-viittauksilla; katsoppa vaikka ylhäältä @math-fi-quadratic ja @math-fi-energy. #lorem(50)


== Koodilohkot

Lyhyt koodilohko ei saa rivinumeroita eikä kuvatekstiä. Katso esimerkki alta (ks. @code-block-fi-summa).

// Notice how referencable short blocks are wrapped in an empty figure
#figure()[
  ```python
  def summa(a, b):
      return a + b
  ```
] <code-block-fi-summa>

Pitkä (vähintään 10 rivin) koodilohko saa rivinumerot ja vaatii kuvatekstin:

#figure(
  caption: [Fibonaccin luvun laskeminen iteratiivisesti.],
)[
  ```python
  def fibonacci(n):
      if n <= 0:
          return []
      elif n == 1:
          return [0]
      elif n == 2:
          return [0, 1]
      else:
          fib = [0, 1]
          for i in range(2, n):
              next_fib = fib[i - 1] + fib[i - 2]
              fib.append(next_fib)
          return fib
  ```
] <code-block-fi-fibonacci>

Pitkään koodilohkoon voi viitata, esim. @code-block-fi-fibonacci.


== Tässä on tarkoituksella aivan naurettavan pitkä otsikko siitä, kuinka kuvia voidaan tai voidaan olla käyttämättä

#lorem(75)

#figure(
  image("1000x1000-luma200-test-image.png", alt: "Esimerkkikuva"),
  caption: [Tämä on esimerkkikuva, joka on tarkoitettu regressiotestaukseen. Kuva on 1000x1000 pikseliä ja sen sisältö on tasaisen harmaa rgb(200,200,200).],
)

#lorem(75)

#figure(
  image("1000x500-luma200-test-image.png", alt: "Esimerkkikuva", width: 80%),
  caption: [Kuva on 1000x500 pikseliä ja sen sisältö on tasaisen harmaa rgb(200,200,200). Se on venytetty koko 80 prosentin leveyteen. Kuvatekstissä viitataan lähteeseen @knuth1991texbook ja koodiin @code:block-fi-summageneralisoitu.],
)

#lorem(50). Alla on vielä varmuuden vuoksi lisää koodia.

#figure()[
  ```python
  def summa_generalisoitu(a, *args):
      return a + sum(args)
  ```
] <code:block-fi-summageneralisoitu>

== Taulukko

#lorem(25). Taulukolla pitää olla kuvateksti, jotta voit viitata siihen tekstistä (ks. @table-fi-carbonara).

#figure(
  table(
    columns: 2,
    table.header([Määrä], [Ainesosa]),
    [150 g], [Guanciale],
    [3 kpl], [Keltuaista],
    [50 g], [Pecorino Romano -juustoa],
    [30 g], [Parmigiano Reggiano -juustoa],
    [1 g], [Mustapippuria],
  ),
  caption: [Pasta carbonaran ainesosat.],
) <table-fi-carbonara>

#lorem(20). Taulukon oletusmuotoiluja voidaan tarvittaessa ohittaa
paikallisesti. Esimerkiksi @table-fi-custom käyttää koko tekstialueen leveyttä,
sisältää neljä saraketta ja yhdistää soluja pystysuunnassa.



#figure(
  table(
    // Fractional columns together occupy the available width.
    columns: (1.1fr, 1.4fr, 2fr, 1fr),

    table.header([Ryhmä], [Luokka], [Kuvaus], [Arvo]),

    table.cell(rowspan: 2)[A],
    table.cell(rowspan: 2)[Ensimmäinen],
    [Lorem ipsum dolor sit amet],
    [12],

    [Consectetur adipiscing elit],
    [24],

    table.cell(rowspan: 2)[B],
    table.cell(rowspan: 2)[Toinen],
    [Sed do eiusmod tempor],
    [36],

    [Incididunt ut labore],
    [48],
  ),
  caption: [Esimerkki paikallisesti mukautetusta taulukosta.],
) <table-fi-custom>



#lorem(20). Taulukon oletusmuotoiluja voidaan tarvittaessa ohittaa
paikallisesti. Esimerkiksi @table-fi-superfunky käyttää koko tekstialueen leveyttä,
sisältää neljä saraketta ja yhdistää soluja pystysuunnassa.

#{
  // Override the template's bold first row for this table only.
  show table.cell.where(y: 0): set text(weight: "regular")

  [
    #figure(
      table(
        // Fractional columns together occupy the available width.
        columns: (1.1fr, 1.4fr, 2fr, 1fr),

        table.header([Ryhmä], [Luokka], [Kuvaus], [Arvo]),

        table.cell(rowspan: 2)[A],
        table.cell(rowspan: 2)[Ensimmäinen],
        [Lorem ipsum dolor sit amet],
        [12],

        [Consectetur adipiscing elit],
        [24],

        table.cell(rowspan: 2)[B],
        table.cell(rowspan: 2)[Toinen],
        [Sed do eiusmod tempor],
        [36],

        [Incididunt ut labore],
        [48],
      ),
      caption: [Esimerkki jossa halutaan mukauttaa taulukon muotoilua. Tässä taulukossa ensimmäinen rivi ei ole lihavoitu, vaikka se onkin taulukon otsikkorivi.],
    ) <table-fi-superfunky>
  ]
}

/*
===========================================================================
Sisältö, joka tavallisesti tuotaisiin chapters/-hakemistosta, loppuu tähän.
===========================================================================
*/


#template.render-ai-usage(
  language: language,
  tools: [
    - Lorem Ipsum 4.0
    - Generative Pre-Trained Sit Amet 5.2
    - SmaLLM Model 3.1.5
  ],
  usage: [
    #lorem(50)

    #lorem(50)
  ],
)

#template.render-bibliography(language: language, source: path("test-references.bib"))

// Arabic page numbers stop here; appendix pages carry their own "Liite N i/total" numbering.
#set page(numbering: none)

#let appendix-items = (
  (
    title: "Lorem ipsum kielen säännöt",
    content: [#lorem(140)], // Can be of any length now
  ),
  (
    title: "Dolor sit amet -aatteen diskurssi",
    content: [
      #lorem(150)

      #lorem(100)

      #lorem(70)

      #lorem(150)
    ],
  ),
)

#template.render-appendices(language: language, items: appendix-items)

