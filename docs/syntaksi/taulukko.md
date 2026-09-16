# Taulukko

Taulukot tehdään Typstin vakio-ominaisuuksilla (`table`-komento), eikä `kamk-thesis`-mallipohja tuo siihen omaa erikoissyntaksia. Mallipohja vain muotoilee taulukot automaattisesti: kuvateksti (`caption`) sijoitetaan taulukon *yläpuolelle* ja ensimmäinen rivi lihavoidaan, koska se on yleensä otsikkorivi.

Jokaisella taulukolla on oltava kuvateksti, ja siihen on viitattava tekstistä esim. `@taulukko-carbonara`. Tämän takia taulukko käärtään aina `figure`-komennon sisään ja sille annetaan tunniste (`label`):

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
) <taulukko-carbonara>
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
) <taulukko-mukautettu>
```

## Muotoilun ohittaminen paikallisesti

Mallipohjan oletusmuotoiluja (esim. otsikkorivin lihavointi) voi tarvittaessa ohittaa yhdelle taulukolle kerrallaan `show`-säännöllä, kääräisemällä koko `figure` sen vaikutusalueelle:

```typst
#{
  show table.cell.where(y: 0): set text(weight: "regular")

  [
    #figure(
      table(...),
      caption: [Esimerkki jossa otsikkorivi ei ole lihavoitu.],
    ) <taulukko-oma-tyyli>
  ]
}
```

Tätä tarvitaan harvoin, eikä sitä ole pakko osata – useimmiten oletusmuotoilu riittää hyvin.