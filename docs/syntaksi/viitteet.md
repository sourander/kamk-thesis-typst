# Viitteet

!!! tip

    Tämä dokumentaatio ja [Lähdeluettelo](lahdeluettelo.md)-dokumentaatio ovat sisarukset. Tässä käsitellään sitä, miten viitteet lisätään tekstin sisälle. Lähdeluettelon luominen on käsitelty Lähdeluettelo-dokumentaatiossa.

    Jos et ole lukenut sitä, lue se ensin.

Tämä materiaali ei pyri olemaan sisällön puolesta kattava ohjeistus tekstiviitteiden laatimisesta. Nojaa näissä KAMK Kirjaston [Vancouver: Lähdeviitteet ja lähdeluettelo](https://libguides.kamk.fi/vancouver)-ohjeistukseen. Tässä aihe käsitellään Typst:n teknisen tekemisen näkökulmasta, eli miten viitteet lisätään Typst-dokumenttiin. On oletus, että olet jo lisännyt lähteet `references.bib`-tiedostoon.

## Minuutin ohje

Kuvitellaan, että sinulla on käsissäsi No Strach Pressin kirja "Introduction to System Programming in Linux" (Weiss, 2025). Kyseessä on fyysinen kirja, joten lähteluettelon vaatimuksena pitäisi löytyä kentät: author, title, date, publisher ja lisäksi saatavuuden muakan location, edition ja url. Lisäät siis (Zoteron avulla tai käsin) seuraavan viitteen `references.bib`-tiedostoon:

```bibtex
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

```typst
Putki-operaattori (`|`) on tuettu useimmissa kuorissa (_engl. shell_), kuten
Bash-kuoressa, ja se mahdollistaa yhden komennon tulosteen syöttämisen toisen
komennon syötteeksi @weiss2025introduction[s.~123--125].
```

Tpyst hallinnoi sinun puolestasi lähdeluettelon muodostamisen CSL-tiedostossa määriteltyjä sääntöjä vasten. Viite saa automaattisesti oman juoksevan numeron esiintymisjärjestyksen mukaan.

!!! tip "Miksi tilde?"

    Komennossa oleva tilde (`~`) on merkki, joka kertoo Typst-kääntäjälle, että kyseessä on _non-breaking space_, eli välilyönti, joka ei salli rivin katkeamista sen kohdalta. Tähän kohtaan lausetta päätyvä rivinvaihto tekisi viittauksesta vaikean lukea.

## Eri tavat käyttää

Alla taulukossa eri tavat, joilla saatat haluta käyttää viittausta:

| Tapa                    | Esimerkki                                 | Selitys                                                                                                             |
| ----------------------- | ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| Viittaus                | `@nameTitle1999`                          | Viittaus ilman sivunumeroa. Viittaat koko teokseen; totuus ei siis löyty tietyltä sivualueelta vaan koko teoksesta. |
| Viittaus sivunumeroilla | `@nameTitle1999[s.~123--125]`             | Viittaus tietylle sivualueelle.                                                                                     |
| Viittaus kappaleella    | `@nameTitle1999[luku 13 Pipes and FIFOs]` | Viittaus tiettyyn kappaleeseen. Kätevä e-kirjan kanssa, josta puuttuu sivunumerot (esim. O'Reilly).                 |
| Viittaus aikakoodilla   | `@nameTitle1999[00:01:15--00:02:30]`      | Videon, Pocastin ja vastaavan kanssa käyttökelpoinen.                                                               |
