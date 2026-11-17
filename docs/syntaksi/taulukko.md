# Taulukko

Taulukot tehdään Typstin vakio-ominaisuuksilla (`table`-komento), eikä `kamk-thesis`-mallipohja tuo siihen omaa erikoissyntaksia. Mallipohja vain muotoilee taulukot automaattisesti: kuvateksti (`caption`) sijoitetaan taulukon *yläpuolelle* ja ensimmäinen rivi lihavoidaan, koska se on yleensä otsikkorivi.

Jokaisella taulukolla on oltava kuvateksti, ja siihen on viitattava tekstistä esim. `@tab:carbonara`. Tämän takia taulukko käärtään aina `figure`-komennon sisään ja sille annetaan tunniste (`label`):

```typst
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
) <tab:carbonara>
```

Numero näkyy kuvatekstissä (esim. **Taulukko 1**), ja numerointi on globaali koko dokumentin läpi, samaan tapaan kuin kuvilla ja koodilohkoilla.

## Sarakkeiden koko ja solujen yhdistäminen

Typstin oma `table`-komento taipuu myös monimutkaisempiin tarpeisiin, jos sellaisia tulee vastaan. Esimerkiksi sarakkeiden leveydet voi antaa suhteellisina (`fr`), ja soluja voi yhdistää pystysuunnassa `table.cell(rowspan: ...)`-parametrilla:

```typst
#figure(
  table(
    // Suhteelliset sarakkeet jakavat käytettävissä olevan leveyden.
    columns: (1.1fr, 1.4fr, 2fr, 1fr),

    table.header([Ryhmä], [Luokka], [Kuvaus], [Arvo]),

    table.cell(rowspan: 2)[A],
    table.cell(rowspan: 2)[Ensimmäinen],
    [Lorem ipsum dolor sit amet],
    [12],

    [Consectetur adipiscing elit],
    [24],
  ),
  caption: [Esimerkki mukautetusta taulukosta.],
) <tab:mukautettu>
```

## Esimerkki tyylitellystä taulukosta

Jos taulukossa on pidempiä tekstejä, sen luettavuutta ja tilankäyttöä voi parantaa pienentämällä taulukon tekstikokoa `text(size: 10pt, ...)`-kääreellä sekä määrittämällä sarakkeiden leveydet (`columns`), tasaukset (`align`) ja reunaviivat (`stroke`). Voit kopioida alla olevan esimerkin suoraan omaan mallipohjaasi ja kokeilla, miltä se näyttää:

```typst
#figure(
  text(size: 10pt, table(
    columns: (auto, auto, auto),
    align: (left, left),
    stroke: 0.5pt,

    // Otsikkorivi
    table.header([*Tarkastettava asia*], [*Kyllä*], [*Ei*]),

    // Taulukon sisältö
    [Aloituskysymykset kysyvät helppoja faktoja], [], [],
    [Pääkysymykset ovat enemmistö kysymyksistä], [], [],
    [Vain yksi kysymys kysytään kerrallaan], [], [],
    [Kysymykset liittyvät tutkimusongelmaan], [], [],
    [Kysymykset ovat pääasiassa avoimia], [], [],
    [Kysymykset välttelevät vierasta termistöä], [], [],
    [Useimmat kysymykset pyytävät osallistujaa kuvailemaan kokemuksia ja tunteita], [], [],
    [Päättävät kysymykset antavat vastaajalle mahdollisuuden tuoda esille muita näkökulmia], [], [],
    [Lopussa on kiitokset ja aie pysyä yhteydessä], [], [],
  )),
  caption: [IPR-mallin mukainen tarkistuslista haastatteluiden suunnitteluun ja toteutukseen, mukaillen @castillo-montoyaPreparingInterviewResearch2016.],
) <tab:ipr-checklist>
```

!!! tip "Kokeile omassa pohjassa"

    Jos kokeilet esimerkkiä suoraan puhtaassa mallipohjassa, vaihda kuvatekstin lähdeviite `@castillo-montoyaPreparingInterviewResearch2016` johonkin omassa `references.bib`-tiedostossasi olevaan lähteeseen (esim. oletuksena mukana tulevaan `@gutmanBecomingDataHead2021`).

## Muotoilun ohittaminen paikallisesti

Mallipohjan oletusmuotoiluja (esim. otsikkorivin lihavointi) voi tarvittaessa ohittaa yhdelle taulukolle kerrallaan `show`-säännöllä, kääräisemällä koko `figure` sen vaikutusalueelle:

```typst
#{
  show table.cell.where(y: 0): set text(weight: "regular")

  [
    #figure(
      table(...),
      caption: [Esimerkki jossa otsikkorivi ei ole lihavoitu.],
    ) <tab:oma-tyyli>
  ]
}
```

Tätä tarvitaan harvoin, eikä sitä ole pakko osata – useimmiten oletusmuotoilu riittää hyvin.