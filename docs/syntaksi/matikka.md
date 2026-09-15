# Matikka

Typstillä on sisäänrakennettu matematiikkatila, eikä `kamk-thesis`-mallipohja tuo siihen juurikaan omaa lisäystä. Ainoa mallipohjan tekemä muutos on, että lohkotason (numeroitujen) yhtälöiden numerot esitetään sulkeissa, esim. `(1)`, KAMK:n käytännön mukaisesti. Kaikki muu alla kuvattu on Typstin omaa, vakiotoiminnallisuutta.

## Inline-matematiikka

Lyhyt, tekstin sisään upotettu matematiikka kirjoitetaan `$`-merkkien väliin ilman ylimääräisiä välilyöntejä lausekkeen ja `$`-merkkien välissä. Tämä ei saa numeroa, eikä sitä ole tarkoituskaan numeroida. `kamk-thesis`-mallipohja ei tuo tähän mitään lisäyksiä, vaan Typstin oma syntaksi toimii sellaisenaan:

## Numeroitu yhtälö

Kun yhtälö kirjoitetaan omaksi lohkokseen, Typst asettaa sen omalle rivilleen ja numeroi sen automaattisesti juoksevalla numerolla:

```typst
#math.equation(
  alt: "x on yhtä kuin miinus b plus tai miinus neliöjuuri b toiseen 
  miinus neljä a c, jaettuna kahdella a:lla",
  block: true,
  $ x = (-b plus.minus sqrt(b^2 - 4a c)) / (2a) $,
) <yhtalo-toisen-asteen>
```

!!! warning

    Kun opinnäytetyö viedään PDF/A- tai PDF/UA-muotoon, jokaiselle lohkotason yhtälölle **on annettava alt-teksti**. Ilman sitä vienti epäonnistuu etkä voi palauttaa työtä Theseukseen. Tämän takia sinun tulee käyttää tätä pidempää `math.equation()`-syntaksia. Näet Typstin dokumentaatiossa myös lyhyemmän syntaksin, mutta älä käytä sitä. Se ei mahdollista alt-tekstin asettamista.

Numero näkyy sulkeissa rivin oikeassa reunassa, esim. **(1)**. Numerointi on globaali koko dokumentin läpi; se ei nollaudu lukujen väliin. Alt-teksti kuvaa kaavan luonnollisella kielellä, ikään kuin lukisit sen ääneen.
