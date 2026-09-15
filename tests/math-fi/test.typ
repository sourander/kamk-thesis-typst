#import "/src/core/config.typ": setup-document, setup-body-page

#let language = "fi"

// Apply base fonts and text settings
#show: setup-document.with(
  title: "Does not matter here",
  authors: ("Not used here",),
  language: language
)

// Apply body-page geometry and heading styles, including parenthesized equation numbering.
#show: setup-body-page.with(language: language)

= Testiluvun otsikko

Inline-matematiikka toimii ilman erillistä numerointia: $a^2 + b^2 = c^2$.

Lohkotason yhtälö saa juoksevan numeron sulkeissa:

#math.equation(
  alt: "x on yhtä kuin miinus b plus tai miinus neliöjuuri b toiseen 
  miinus neljä a c, jaettuna kahdella a:lla",
  block: true,
  $ x = (-b plus.minus sqrt(b^2 - 4a c)) / (2a) $,
) <math-fi-quadratic>

Toinen numeroitu yhtälö, jotta juokseva numerointi voidaan tarkistaa:

#math.equation(
  alt: "E on yhtä kuin m kertaa c toiseen",
  block: true,
  $ E = m c^2 $,
) <math-fi-energy>

Yhtälöihin voi viitata numeroiden sijaan label-viittauksilla, esim. @math-fi-quadratic ja @math-fi-energy.
