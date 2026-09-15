# PDF-lukija

Typst tuottaa PDF-tiedoston, joten sinulla tulee olla jokin lukija, jolla voit avata ja tarkastella PDF-tiedostoja. Kirjoitusvaiheessa sinulla on tarve käyttää PDF-lukijaa, joka ==osaa automaattisesti päivittää näkymän, kun PDF-tiedosto on muuttunut.== Tämä johtuu siitä, että aiemmin esitelty `just watch` (eli `typst watch`) -komento pitää terminaalissa käynnissä prosessia, joka tarkkailee tiedostojen muutoksia ja kääntää PDF-tiedoston uudelleen. Kun PDF-tiedosto on käännetty uudelleen, haluat nähdä muutokset heti ilman, että sinun tarvitsee sulkea ja avata PDF-tiedostoa uudelleen.

Tämän voi ratkaista ainakin seuraavilla tavoilla:

* macOS: [Skim](https://skim-app.sourceforge.io/)
* Windows: [SumatraPDF](https://www.sumatrapdfreader.org/free-pdf-reader)
* Ubuntu Linux: [GNOME Document Viewer](https://apps.gnome.org/en-GB/Papers/) (asentuu valmiiksi GNOME-työpöytäympäristön mukana)

Lisäksi kaikille käyttöjärjestelmille löytyy Visual Studio Coden laajennus, joka esitellään myöhemmin. Tämän materiaalin kirjoittajan suosikki on Ubuntun oma Document Viewer. Se on nopea, yksinkertainen ja osaa lisäksi hyödyllisen "Sneak Peak"-ominaisuuden, joka mahdollistaa viittauksen kohdan tarkastelun ilman että pläräät lähdeluetteloon ja takaisin. Toistaiseksi en ole löytänyt muille käyttöjärjestelmille PDF-lukijaa, joka osaisi tämän ominaisuuden. Jos tiedät sellaisen, kerro siitä minulle, niin lisään sen tähän dokumentaatioon.

!!! warning

    Adobe Acrobat Reader on monille tuttu ja (perustoimintojen osalta) ilmainen PDF-lukija, mutta se ei osaa automaattisesti päivittää näkymää, kun PDF-tiedosto muuttuu. Unohda se kirjoittamisen aikana.
