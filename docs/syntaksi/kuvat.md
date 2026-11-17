# Kuvat

Kuvat lisätään Typstin vakio-ominaisuuksilla (`image`- ja `figure`-komennoilla), eikä `kamk-thesis`-mallipohja tuo niihin omaa erikoissyntaksia. Jokainen opinnäytetyön kuva kääritään `figure`-komennon sisään, jolloin se saa kuvatekstin (`caption`) ja juoksevan numeroinnin. Lisäksi jokaiselle kuvalle on annettava vaihtoehtoinen teksti (`alt`) saavutettavuusvaatimusten vuoksi.

## Kuvan lisääminen

Kun haluat lisätä kuvan ja viitata siihen tekstistä (esim. `@fig:arkkitehtuuri`), kääri `image`-komento `figure`-komennon sisään ja anna sille kuvateksti, `alt`-teksti sekä tunniste (`label`):

```typst
#figure(
  image("kuvat/arkkitehtuuri.png", alt: "Järjestelmän arkkitehtuurikaavio, jossa asiakassovellus keskustelee palvelimen ja tietokannan kanssa."),
  caption: [Järjestelmän yleisarkkitehtuuri.],
) <fig:arkkitehtuuri>
```

Kuvateksti näytetään automaattisesti kuvan alapuolella (esim. **Kuva 1**). Numerointi on globaali koko dokumentin läpi eikä nollaudu lukujen välillä, samaan tapaan kuin taulukoilla ja koodilohkoilla.

!!! warning "Alt-teksti on pakollinen"

    Kun opinnäytetyö viedään PDF/UA-1-muotoon, jokaiselle kuvalle **on annettava `alt`-teksti**. Ilman sitä saavutettavuusvaatimukset eivät täyty ja PDF-vienti epäonnistuu, etkä voi palauttaa työtä Theseukseen. Alt-tekstin tulee kuvata kuvan olennainen sisältö luonnollisella kielellä ruudunlukijaa varten.

## Kuvan koon säätäminen ja viitteet kuvatekstissä

Kuvan kokoa voi tarvittaessa mukauttaa `image`-komennon `width`- tai `height`-parametreilla (esim. suhteessa tekstialueen leveyteen). Kuvatekstissä voi myös käyttää tavalliseen tapaan lähdeviitteitä ja muita viittauksia:

```typst
#figure(
  image("kuvat/mittaustulokset.png", alt: "Pylväsdiagrammi mittaustuloksista vuosina 2024–2026.", width: 80%),
  caption: [Mittaustulosten kehitys tarkastelujaksolla @knuth1991texbook.],
) <fig:mittaustulokset>
```

Tuetut kuvamuodot ovat Typstin vakiomuodot: PNG, JPEG, GIF, SVG ja WebP.
