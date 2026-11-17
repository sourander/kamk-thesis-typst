# VS Code

Visual Studio Code on jo aiemmilta kursseilta sivulle tuttu, ja olet epäilemättä jo asentanut sen, joten siihen ei keskitytä tässä ohjeessa. Tämä ohje liittyy kyseisen editorin laajennusten eli Extensioneiden asentamiseen ja käyttöön.

## Tinymist Typst

[Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) on kielimoottori, joka mahdollistaa Typst-kielen automaattisen tarkistuksen (_engl. linter_) ja muita ominaisuuksia. Voit asentaa sen Visual Studio Coden Extensins-valikosta.

Ärsyttävä ominaisuus lisäosassa on se, että ns. päädokumenttia ei voi tietääkseni pysyvästi tallentaa esimerkiksi `.vscode/settings.json`-tiedostoon, vaan se pitää määritellä joka kerta uudelleen kun käynnistät VS Coden. Tämä on kuitenkin pieni vaiva. Miksikö päädokumentti pitää määritellä? Koska opinnäytetyösi koostuu useista Typst-tiedostoista, mutta vain yksi niistä on se, jota käännetään. Tämä on siis ikään kuin _entry point_.

Se onnistuu näin:

1. Avaa päätiedosto `thesis.typ` aktiivsena olevaan editoriin.
2. Paina Ctrl+Shift+P (tai Cmd+Shift+P Macilla). Aukeaa pop-up -valikko.
3. Etsi valikosta: "Typst: Pin the Main File to the Currently Open Document" ja valitse se.

Jatkossa voit mennä toiseen tiedostoon, kuten `chapters/johdanto.typ`, ja Typst-linteri tietää silti, että päädokumentti on `thesis.typ`. Näin esimerkiksi viitteiden tarkistus toimii oikein, koska päädokumentti on se, jossa viitteet kootaan.

!!! tip

    Lisäosan avulla on mahdollista klikata "Typst Preview"-näppäintä, kunhan päädokumentti on aktiivisena ja tilassa _pinned_. Tämä avaa esikatselun, jossa tekstin klikkaaminen synkronoi avatun `.typ`-tiedoston sijainnin esikatselussa. Tämä on kätevä ominaisuus ja toimii vaihtoehtoja `typst watch`-komennolle ja ulkoiselle PDF-lukijalle. Video-ohjeessa avataan tämän hyötyjä ja haittoja: ohjeen laatija on käyttänyt kumpaakin sekaisin riippuen siitä, kirjoitetaanko uutta sisältöä vai tehdäänkö tarkistuksia ja korjauksia.
