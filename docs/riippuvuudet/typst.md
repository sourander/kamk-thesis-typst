# Typst

Typst on uusi, moderni dokumenttien kirjoituskieli, joka perustuu LaTeX-ekosysteemiin mutta on suunniteltu olemaan helpommin käytettävä ja yksinkertaisempi. Siihen liittyvä Typst-sovellus (https://typst.app/) on maksullinen lisäpalvelu, jolla avoimen lähdekoodin kehittäjät pyrkivät rahoittamaan Typst-kehitystä. Varsinainen Typst-kieli ja sen kääntäjä ovat kuitenkin avoimen lähdekoodin projekteja, joita voi käyttää ilmaiseksi. Me käytämme pääasiassa näitä avoimen lähdekoodin työkaluja, mutta ei ole kiellettyä käyttää opinnäytetyön kirjoittamiseen Typst-sovellusta, jos haluaa.

## Asennus

Typst on saatavilla Windowsille, Macille ja Linuxille. Löydät sen asennusohjeet kullekin alustalle [Open Source at Typst](https://typst.app/open-source/)-sivulta.

## Minuutin ohje

Kun haluat ottaa templaatin käyttöön, mene terminaaliin (miel. Git Bash Windowsissa; Linuxissa ja Macissa voit käyttää mitä tahansa terminaalia) ja aja seuraavat komennot:

```bash
cd ~/Code/hakemisto/johon/haluat/ladata/templaatin

typst init @preview/kamk-thesis
cd kamk-thesis
```

Nyt voit alkaa työskennellä. Seuraavia komentoja ei tarvitse osata ulkoa, vaan ne ovat lisätty `Justfile`-tiedostoon, ja niiden käyttö on kuvattu [Just-dokumentaatiossa](just.md).
