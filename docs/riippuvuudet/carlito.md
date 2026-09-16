# Carlito

Raportti käyttää fonttia nimeltään Carlito, joka on Calibri-fonttia muistuttava avoimen lähdekoodin fontti. Carlito on lisensoitu SIL Open Font License 1.1 -lisenssillä, joka sallii sen vapaasti käytön, muokkaamisen ja jakamisen. Asenna se käyttöjärjestelmääsi. Alla on pikaohjeet yleisimpiin käyttöjärjestelmiin. Jos käytät jotain muuta käyttöjärjestelmää, etsi ohjeet verkosta.

## Windows

1. Lataa Carlito-fontti osoitteesta [Google Fonts](https://fonts.google.com/specimen/Carlito)
2. Pura ladattu ZIP-tiedosto.
3. Avaa kansio, jossa purit tiedoston, ja etsi tiedostot `Carlito-Regular.ttf` ja `Carlito-Bold.ttf`.
4. Kaksoisnapsauta kumpaakin tiedostoa ja valitse "Asenna" tai "Install" asentaaksesi fontin järjestelmääsi.

## macOS

Helpoin tapa on asentaa se Homebrew Caskin kautta:

```bash
brew tap homebrew/cask-fonts
brew install --cask font-carlito
```

## Ubuntu

Helpoin tapa on asentaa se pakettivarastosta:

```bash
sudo apt update
sudo apt install fonts-carlito

# Päivitä font cache
fc-cache -f -v
```
