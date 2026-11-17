# Tärkeät komennot

!!! tip

    On suositeltavaa käyttää Justfileä useasti ajettujen komentojen ajamiseen. Jos et jostain syystä halua tehdä sitä, aja nämä komennot käsin. Justfileen löydät ohjeita sivulta [Valinnaiset/Just](valinnaiset/just.md).

## Typst

### Alusta templaatti

``` bash
typst init @preview/kamk-thesis your-custom-folder-name
```

### Päivätty luonnos

``` bash
typst compile thesis.typ --pdf-standard ua-1 $(date +%Y-%m-%d)-output.pdf
```

??? info "Mikä ihmeen UA-1?"

    Katso [ISO 14289-1](https://pdfa.org/resource/iso-14289-pdfua/). PDF/UA-1 on standardi, joka määrittelee PDF-tiedoston saavutettavuuden. Tämä on hyvä ajaa vähintään aina kun teet luonnoksen, jotta tiedät, että nykyisellään opinnäytetyösi täyttää saavutettavuuden ehdot. Tälle on vaatimuksina muun muassa:

    - Kaikilla kuvilla (`image`) tulee olla `alt`-attribuutti.
    - Tiedostolle on määriteltävä otsikko (`#set document(title: [...])`).
    - Otsikkotasoja tulee käyttää järjestyksessä (esim. älä hyppää suoraan tason 1 otsikosta tasolle 3).
    - Kaikkien dokumentissa käytettyjen fonttien on oltava upotettuina PDF-tiedostoon.

### Lopullinen versio

``` bash
typst compile thesis.typ --pdf-standard a-2a,ua-1 output.pdf
```

??? info "Mikä ihmeen A-2a?"

    Katso [PDF/A](https://fi.wikipedia.org/wiki/PDF/A). PDF/A on standardi, joka määrittelee PDF-tiedoston pitkäaikaissäilytyksen. Versio PDF/A-2 on testattu toimivaksi Theseuksen kanssa.
