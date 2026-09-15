# Nimiö

Nimiöt (_engl. label_) ovat nimiä, joita käytetään viittaamaan eri elementteihin dokumentissa. Nimiön arvon kuuluu olla uniikki. Nimiön arvo on merkkijono hakasulkeissa, kuten `<pizza-spam>` tai `<kuvaaja-xy-much-profit>`. Niitä voi antaa muiden muassa:

- otsikoille,
- kuville,
- taulukoille,
- ja kaavoille

Nimiöt mahdollistavat sen, että voit tekstissä viitata kyseiseen asiaan myöhemmin tai aiemmin. PDF-tiedostossa nämä ovat klikattavia linkkejä.

## Esimerkki

Esimerkkinä olkoon rakenne, jossa viitataan aiempaan otsikkoon:

```typst
// ...
== Pizza ingredients
=== Egg
=== Ham
=== Spam <pizza-spam>  // <== Tuo tuossa on label

== Pea soup ingredients
=== Peas
=== Spam
Spam is a common ingredient in nearly all foods in this galaxy. Remember that section
in which we discussed the ingredients of pizza (see @pizza-spam)?
```

## Nimistandardi

Voi olla hyvä käyttää nimeämiseen de facto standardia, jossa lisäät etuliitteen sen mukaan, mihin nimiö viittaa. Alla taulukossa esimerkit:

| Etuliite | Käyttötarkoitus |
| -------- | --------------- |
| `ch:`    | Luvut           |
| `sec:`   | (Ali)luvut      |
| `fig:`   | Kuvat           |
| `tab:`   | Taulukot        |

Tätä standardia käyttäen yllä olevan pizzaesimerkin nimiö olisi voitu nimetä `sec:pizza-spam`.
