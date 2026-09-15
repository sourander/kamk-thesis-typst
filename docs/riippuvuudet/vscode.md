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

## (Optional) pdf

[vscode-pdf](https://marketplace.visualstudio.com/items?itemName=tomoki1207.pdf) on VS Code -laajennus, joka mahdollistaa PDF-tiedostojen katselun suoraan editorissa. Tämä on ==vaihtoehto== sille, että käytät jotakin ulkoista PDF-lukijaohjelmistoa. Minä suosin ulkoista ohjelmistoa monista syistä, jotka ovat helpompi esitellä videotallenteella kuin tässä tekstinä, joten käyn aihealueen läpi vain ja ainoastaan tämän materiaalin videoversiossa.

