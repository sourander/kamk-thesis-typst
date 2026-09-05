#import "kamk.typ": template

#show: template.with(
  // Perustiedot
  authors: ("Meikäläinen Matti",),
  date: datetime.today(),
  language: "fi",
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

= Johdanto
Tämä on opinnäytetyön ensimmäinen luku. Sivun asetukset (marginaalit yms.) ovat nyt KAMK:n ohjeiden mukaiset tästä eteenpäin automaattisesti.
