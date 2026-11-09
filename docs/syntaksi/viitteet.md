# Viitteet

!!! tip

    Tämä dokumentaatio ja [Lähdeluettelo](lahdeluettelo.md)-dokumentaatio ovat sisarukset. Tässä käsitellään sitä, miten viitteet lisätään tekstin sisälle. Lähdeluettelon luominen on käsitelty Lähdeluettelo-dokumentaatiossa.

    Jos et ole lukenut sitä, lue se ensin.

Tämä materiaali ei pyri olemaan sisällön puolesta kattava ohjeistus tekstiviitteiden laatimisesta. Nojaa näissä KAMK Kirjaston [Vancouver: Lähdeviitteet ja lähdeluettelo](https://libguides.kamk.fi/vancouver)-ohjeistukseen. Tässä aihe käsitellään Typst:n teknisen tekemisen näkökulmasta, eli miten viitteet lisätään Typst-dokumenttiin. On oletus, että olet jo lisännyt lähteet `references.bib`-tiedostoon.

## Minuutin ohje

Kuvitellaan, että sinulla on käsissäsi No Strach Pressin kirja "Introduction to System Programming in Linux" (Weiss, 2025). Kyseessä on fyysinen kirja, joten lähteluettelon vaatimuksena pitäisi löytyä kentät: author, title, date, publisher ja lisäksi saatavuuden muakan location, edition ja url. Lisäät siis (Zoteron avulla tai käsin) seuraavan viitteen `references.bib`-tiedostoon:

``` bibtex
@book{weiss2025introduction,
  title = {Introduction to System Programming in Linux},
    author = {Weiss, Stewart},
    date = {2025},
    publisher = {No Starch Press},
    isbn = {9781718503564},
    location = {San Francisco, CA},
}
```

Kyseessä on noin 700-sivuinen kirja, joten viittaus tekstissä on järkevää tehdä sivunumeroiden kanssa, mikäli viittaat johonkin tiettyyn sivuun tai sivualueeseen. Tämä palvelee sekä sinua itsesäsi, jos haluat tarkistaa viittauksen kohdan myöhemmin, että lukijaa, joka haluaa löytää alkuperäisen viittauksen äärelle. Typst-kielessä viittaus tehdään seuraavasti:

``` typst
Putki-operaattori (`|`) on tuettu useimmissa kuorissa (_engl. shell_), kuten
Bash-kuoressa, ja se mahdollistaa yhden komennon tulosteen syöttämisen toisen
komennon syötteeksi @weiss2025introduction[s.~123--125].
```

Typst hallinnoi sinun puolestasi lähdeluettelon muodostamisen CSL-tiedostossa määriteltyjä sääntöjä vasten. Viite saa automaattisesti oman juoksevan numeron esiintymisjärjestyksen mukaan.

!!! tip "Miksi tilde?"

    Komennossa oleva tilde (`~`) on merkki, joka kertoo Typst-kääntäjälle, että kyseessä on _non-breaking space_, eli välilyönti, joka ei salli rivin katkeamista sen kohdalta. Tähän kohtaan lausetta päätyvä rivinvaihto tekisi viittauksesta vaikean lukea.

## Eri tavat käyttää

Alla taulukossa eri tavat, joilla saatat haluta käyttää viittausta:

| Tapa                              | Esimerkki                                 | Selitys                                                                                                             |
| --------------------------------- | ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| Viittaus                          | `@nameTitle1999`                          | Viittaus ilman sivunumeroa. Viittaat koko teokseen; totuus ei siis löydy tietyltä sivualueelta vaan koko teoksesta. |
| Viittaus koko kappaleeseen        | `@nameTitle1999[.]`                       | Viittaus usean virkkeen kokonaisuuteen ilman sivunumeroa (tulostuu muodossa `[1.]`).                                |
| Viittaus sivunumeroilla           | `@nameTitle1999[s.~123--125]`             | Viittaus tietylle sivualueelle yhden virkkeen lopussa.                                                              |
| Viittaus sivunumeroilla (kappale) | `@nameTitle1999[s.~123--125.]`            | Viittaus tietylle sivualueelle, kun viitataan usean virkkeen kokonaisuuteen (tulostuu muodossa `[1, s. 123–125.]`). |
| Viittaus kappaleella              | `@nameTitle1999[luku 13 Pipes and FIFOs]` | Viittaus tiettyyn kappaleeseen. Kätevä e-kirjan kanssa, josta puuttuu sivunumerot (esim. O'Reilly).                 |
| Viittaus aikakoodilla             | `@nameTitle1999[00:01:15--00:02:30]`      | Videon, Podcastin ja vastaavan kanssa käyttökelpoinen.                                                              |

## Pisteen paikka viitteessä (yksi virke vs. useampi virke)

KAMK:n opinnäytetyöohjeistuksen mukaan pisteen sijainnilla kerrotaan, kohdistuuko viite vain yhteen virkkeeseen vai useamman virkkeen kokonaisuuteen (tyypillisesti koko tekstikappaleeseen):

- **Viittaus yhteen virkkeeseen:** Virkkeen päättävä piste tulee viitteen *jälkeen*, eikä hakasulkeiden sisälle laiteta pistettä (esim. `...tekstiä [1].` tai `...tekstiä [1, s. 123–125].`).
- **Viittaus useaan virkkeeseen:** Viimeisen virkkeen päättävä piste tulee *ennen* viitettä, ja hakasulkeiden *sisälle* lisätään piste (esim. `...tekstiä. [1.]` tai `...tekstiä. [1, s. 123–125.]`).

Typstissä piste saadaan hakasulkeiden sisälle antamalla viitteelle tarkenteeksi pelkkä piste `[.]` tai päättämällä sivunumerotarkenne pisteeseen:

```typst
// Yhden virkkeen viittaus (piste viitteen perässä):
Putki-operaattori on tuettu useimmissa kuorissa @weiss2025introduction.
Putki-operaattori on tuettu useimmissa kuorissa @weiss2025introduction[s.~123--125].

// Usean virkkeen / koko kappaleen viittaus (piste ennen viitettä JA hakasulkeiden sisällä):
Tekniikan Sanastokeskuksen mukaan resoluutio ilmaisee, miten tarkasti kuvan
yksityiskohdat pystytään esittämään näytössä tai painettuna. Kuvan resoluutio
ilmaistaan esimerkiksi pikseleinä pituusmittaa kohti. @weiss2025introduction[.]

Tekniikan Sanastokeskuksen mukaan resoluutio ilmaisee, miten tarkasti kuvan
yksityiskohdat pystytään esittämään näytössä tai painettuna. Kuvan resoluutio
ilmaistaan esimerkiksi pikseleinä pituusmittaa kohti. @weiss2025introduction[s.~123--125.]
```

Kaikki neljä muotoa ovat siis täysin käypiä, mutta pisteellisillä muodoilla (`[.]` ja `[s.~123--125.]`) on erityismerkitys: ne viittaavat yhtä virkettä laajempaan edeltävään kokonaisuuteen:

```typst
@weiss2025introduction
@weiss2025introduction[.]
@weiss2025introduction[s.~123--125]
@weiss2025introduction[s.~123--125.]
```
