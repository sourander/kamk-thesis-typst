# Koodi

`kamk-thesis`-mallipohja tuo koodilohkoille oman `code-block()`-funktion, joka valitsee ulkoasun automaattisesti lohkon pituuden perusteella. Kaikki koodilohkot saavat vaaleanharmaan taustan ja ovat leveydeltään yhtä leveitä kuin muu leipäteksti (marginaalien sisäpuolinen leveys).

## Lyhyt koodilohko

Alle 10 rivin koodilohko ei saa rivinumeroita eikä kuvatekstiä (`caption`). Sillä on kuitenkin juokseva numero, joka näytetään suluissa (esim. `(2)`) lohkon oikeassa laidassa, samaan tapaan kuin (matematiikka)kaavoilla (ks. [Matikka](matikka.md)):

```typst
#code-block(
  ```python
  def summa(a, b):
      return a + b
  ```
)
```

## Pitkä koodilohko

Vähintään 10 rivin koodilohko saa juoksevat rivinumerot ja *vaatii* kuvatekstin:

```typst
#code-block(
  caption: [Fibonaccin luvun laskeminen iteratiivisesti.],
  ```python
  def fibonacci(n):
      if n <= 1:
          return n

      previous, current = 0, 1
      for _ in range(2, n + 1):
          previous, current = current, previous + current

      return current

  print(fibonacci(10))
  ```
) <fibonacci>
```

Pitkät ja lyhyet koodilohkot jakavat saman juoksevan numeroinnin: pitkä lohko näyttää numeronsa kuvatekstinä (esim. **Koodi 1**), kun taas lyhyt lohko näyttää oman numeronsa suluissa (esim. `(2)`) lohkon oikeassa yläkulmassa eikä sitä luetella kuvien luettelossa. Numerointi on globaali koko dokumentin läpi eikä nollaudu lukujen väliin. Koodilohkoon voi viitata label-viittauksella, esim. `@fibonacci`.

## Kummankin lohkotyypin yhteiset piirteet

- Vaaleanharmaa tausta (määritelty `kamk-gray`-värinä `src/core/colors.typ`-tiedostossa).
- Täysi tekstin leveys.
- Syntaksiväritys `lang`-tunnisteen (esim. `python`) mukaan, Typstin oman `raw`-elementin kautta.
- Valinnainen `alt`-teksti saavutettavuutta varten.
