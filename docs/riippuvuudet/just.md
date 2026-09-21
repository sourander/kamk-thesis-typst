# Just

Jotta sinun, opiskelijan, ei tarvitse muistaa suurta määrää erilaisia komentoja, yleisimmät ovat koottu yhtee `Justfile`-tiedostoon. Tämän tiedoston avulla voit suorittaa komentoja yksinkertaisesti kirjoittamalla `just <komento>` terminaaliin. Typst package repositoryn säännöt estävät Justfile-tiedoston julkaisemisen Typst Universeen, joten sen sisältö ylläpidetään tässä ohjeessa. Kopioi sisältö omaan projektiisi, mikäli haluat hyötyä lyhennetyistä komennoista.

## Asennus

Just:n oletus on, että järjestelmästä löytyy `sh` (eli UNIX Shell yhteensopiva komentotulkki). Linux ja macOS käyttöjärjestelmistä tämä löytyy hyvinkin natiivisti. Windowsissa se pitää asentaa, mutta **se asentuu Git for Windowsin mukana**. Kunhan kutsut `just`-komentoa Git Bash terminaalissa, sinulla on siis kaikki hyvin.

Asennusohjeet löytyvät [Just Manuaalista](https://just.systems/man/en/introduction.html) tai [Just GitHub-sivulta](https://github.com/casey/just).

## Justfile

### Tiedoston sisältö

```makefile title="Justfile"
# Variables
ENTRY_FILE := "thesis.typ"
OUT_DIR := "build"
OUT_FILE := OUT_DIR + "/thesis.pdf"

# Draft will be written to build/thesis-draft-YYYY-MM-DD.pdf and use the PDF/UA-1 standard.
OUT_DRAFT_FILE := OUT_DIR + "/thesis-draft-" + datetime("%Y-%m-%d") + ".pdf"

# Default recipe: list all available recipes
default:
    @just --list

# Render a update-on-save preview of the thesis PDF.
watch:
    mkdir -p {{OUT_DIR}}
    typst watch --root . {{ENTRY_FILE}} {{OUT_FILE}}

# Render a date-versioned one-off build of the thesis PDF (PDF/UA-1 compliant)
draft:
    mkdir -p {{OUT_DIR}}
    typst compile --root . --pdf-standard ua-1 {{ENTRY_FILE}} {{OUT_DRAFT_FILE}}
    @echo "Draft build successful: {{OUT_DRAFT_FILE}}"
```

Kopioi yllä oleva sisältö oman projektisi juureen, samaan hakemistoon, missä `thesis.typ` sijaitsee. Tämän jälkeen voit ajaa komentoja alla neuvotulla tavalla.

### Komentojan ajaminen

Käyttö on helppoa kuin heinänteko. Kirjoita siinä hakemistossa, missä tämän projektin `Justfile` sijaitsee, terminaaliin:

```bash
just
```

Komento listaa kaikki käytettävissä olevat komennot. Komentoja voi ajaa yksinkertaisesti kirjoittamalla:

```bash
just <komento>
```

### Tärkeimmät komennot

Tyypilliset komennot, joita opiskelija tarvitsee, ovat:

* `just watch` - Komento, joka päivittää PDF-tiedostoa aina kun lähdetiedostoja muokataan. Tätä käytät opinnäytetyötä kirjoittaessasi.
* `just draft` - Komento, joka luo versionumeroidun PDF/UA-1 standardin mukaisen PDF-tiedoston. Tätä käytät, kun haluat lähettää opinnäytetyösi tarkastettavaksi.

### Omien komentojen lisääminen

On täysin sallittua lisätä sinulle hyödyllisiä komentoja `Justfile`-tiedostoon. Alla on ehdotus komennosta, joka voi olla hyödyllinen:

```makefile title="Justfile"
# Open in Skim (macOS)
skim:
    open -a Skim {{OUT_FILE}}

# Open in Ubuntu default Document Viewer
dc:
    gio open {{OUT_FILE}} > /dev/null 2>&1
```

Alla toinen, josta voi olla hyötyä, jos haluat varmistaa että kaikki PNG-kuvat ovat maksimissaan x pikseliä pidemmältä sivultaan:

```makefile title="Justfile"
# Resizes all PNG images to a maximum of 2000px on the longest side
optimize-images:
    mogrify -resize 2000x2000\> -format png assets/*.png
```
