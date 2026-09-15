# Just

Jotta sinun, opiskelijan, ei tarvitse muistaa suurta määrää erilaisia komentoja, yleisimmät ovat koottu yhtee `Justfile`-tiedostoon. Tämän tiedoston avulla voit suorittaa komentoja yksinkertaisesti kirjoittamalla `just <komento>` terminaaliin.

## Asennus

Just:n oletus on, että järjestelmästä löytyy `sh` (eli UNIX Shell yhteensopiva komentotulkki). Linux ja macOS käyttöjärjestelmistä tämä löytyy hyvinkin natiivisti. Windowsissa se pitää asentaa, mutta **se asentuu Git for Windowsin mukana**. Kunhan kutsut `just`-komentoa Git Bash terminaalissa, sinulla on siis kaikki hyvin.

Asennusohjeet löytyvät [Just Manuaalista](https://just.systems/man/en/introduction.html) tai [Just GitHub-sivulta](https://github.com/casey/just).

## Minuutin ohje

Käyttö on helppoa kuin heinänteko. Kirjoita siinä hakemistossa, missä tämän projektin `Justfile` sijaitsee, terminaaliin:

```bash
just
```

Komento listaa kaikki käytettävissä olevat komennot. Komentoja voi ajaa yksinkertaisesti kirjoittamalla:

```bash
just <komento>
```

## Toisen minuutin ohje

Tyypillinen komento, jolla haluat aloittaa opinnäytetyösi kirjoittamisen, on `just watch`. Sen määritelmä on tämän dokumentin kirjoitushetkellä:

```bash
# Render a update-on-save preview of the thesis PDF.
watch:
    mkdir -p {{OUT_DIR}}
    typst watch --root . {{ENTRY_FILE}} {{OUT_FILE}}
```

Eli kun kirjoitat `just watch`, Shellissä ajetaan tarkemmin komennot:

```bash
mkdir -p build
typst watch --root . thesis.typ build/thesis.pdf
```

Kyseinen prosessi jää käynnissä olevaan terminaaliin käyntiin. Se tarkkailee tiedostojen muutoksia. Jos päivität jotakin tiedostoa, joka liittyy `thesis.typ`-tiedostoon, Typst-kääntäjä kääntää sen automaattisesti uudelleen ja päivittää PDF-tiedoston.
