# Kansikuva

Opinnäytetyön kansikuva on vakiona placeholder-kuva. Voit päättää tehdä jomman kumman seuraavista:

1. Poista kansikuva kokonaan
2. Korvaa kansikuva valitsemallasi PNG/SVG/JPG-kuvalla.

Alla ohjeet näihin kumpaankin:

## Poista kansikuva

Voit poistaa kansikuvan lisäämällä seuraavan rivin `thesis.typ`-tiedostoon:

```typst
#show: template.frontmatter.with(
  // Perustiedot
  authors: ("Meikäläinen Matti",),
  date: datetime.today(),
  language: language,
  cover-image: false,  // <- Tämä rivi poistaa kansikuvan. False tarkoittaa, että kansikuvaa ei näytetä.
  // ...
)
```

## Lisää oma kansikuva

Ensinnäkin varmista, että sinulla on lupa käyttää kyseistä kuvaa. Noudata tekijänoikeuksia. Tämän jälkeen käy lisäämässä relatiivinen polku kuvaan `thesis.typ`-tiedostoon. Esimerkiksi, jos sinulla on kansikuva nimeltä `foo.jpg` projektin `assets/`-kansiossa, lisää seuraava rivi `thesis.typ`-tiedostoon:

```typst
#show: template.frontmatter.with(
  // Perustiedot
  authors: ("Meikäläinen Matti",),
  date: datetime.today(),
  language: language,
  cover-image: image("assets/foo.jpg", alt: "Alt text"), // <- HOX!
  // ...
)
```

!!! warning "Alt text on pakollinen"

    Alt-teksti on pakollinen, jotta saavutettavuusvaatimukset täyttyvät. Muutoin PDF/A UA-1 compilation tulee nostamaan herjan. Alt-teksti on lyhyt kuvaus siitä, mitä kansikuvassa on. Esimerkiksi: "Kuva, jossa on sininen taivas ja vihreä niitty".

Tämän jälkeen sinun tulee varmistaa, että lähdeluettelossa viitaaan kuvaan. Sitä ei lisätä tyypillisenä lähdeviitteenä, vaan sille on oma arvonsa `render-bibliography`-funktiossa. Lisää siis seuraava rivi `thesis.typ`-tiedostoon:

```typst
#template.render-bibliography(
  language: language,
  source: path("references.bib"),
  cover_image_source: [ Kirjoita tähän. Lue ohje alta. ], // <- HOX!
)
```

Kenttään tulee kirjoittaa viite siten, että lukija tietää yksiselitteisesti, mikä kuva on kyseessä, mistä se on peräisin ja miksi sen saa julkaista tässä yhteydessä. Teksti kirjoitetaan hakasulkeiden väliin, jotta Typst-muotoilut ovat mahdollisia. Sopivia syötteitä hakasulkeiden väliin ovat esimerkiksi:

- `Jani Sourander. _Cover image placeholder_. Public Domain. URL: https://github.com/sourander/kamk-thesis-typst/blob/main/assets/cover_image.svg`
- `Jani Sourander. _Kuva banaanista_. CC-BY-SA 4.0. Ote kotialbumista.`
- `Essi Esimerkki. Teos "Pulu oksalla istui, olevaista pohtien" näyttelykokoelmasta "Eläinkuvia". Julkaistu erityisluvalla. Kopiointi kielletty.`
- `crazycolbster. _Untitled image_. CC-BY-SA 4.0. Saatavilla: https://www.mapillary.com/app/?pKey=847357434628008`
