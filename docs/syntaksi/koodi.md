# Koodi

`kamk-thesis`-mallipohja muotoilee koodilohkot automaattisesti lohkon pituuden perusteella. Erillisiä apufunktioita ei tarvita, vaan voit käyttää Typstin vakio-ominaisuuksia (markdown-tyylisiä koodilohkoja ja `figure`-komentoa). Kaikki koodilohkot saavat vaaleanharmaan taustan ja ovat leveydeltään yhtä leveitä kuin muu leipäteksti.

## Lyhyt koodilohko

Alle 10 rivin koodilohko ei saa rivinumeroita eikä kuvatekstiä (`caption`). Sillä on kuitenkin juokseva numero, joka näytetään suluissa (esim. `(2)`) lohkon oikeassa laidassa, samaan tapaan kuin kaavoilla.

Jos et tarvitse lohkolle viitettä (label), voit vain kirjoittaa koodin suoraan:

````typst
```python
def summa(a, b):
    return a + b
```
````

Jos haluat pystyä viittaamaan lohkoon tekstissä (esim. `@summa`), kääri se tyhjään `figure`-komentoon ja anna sille tunniste:

````typst
#figure()[
  ```python
  def summa(a, b):
      return a + b
  ```
] <summa>
````

## Pitkä koodilohko

Vähintään 10 rivin koodilohko saa automaattisesti juoksevat rivinumerot ja *vaatii* aina kuvatekstin. Se on käärittävä `figure`-komennon sisään:

````typst
#figure(
  caption: [Fibonaccin luvun laskeminen iteratiivisesti.],
)[
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
] <fibonacci>
````

Pitkät ja lyhyet koodilohkot jakavat saman juoksevan numeroinnin: pitkä lohko näyttää numeronsa kuvatekstinä (esim. **Koodi 1**), kun taas lyhyt lohko näyttää oman numeronsa suluissa (esim. `(2)`) lohkon oikeassa reunassa, eikä sitä luetella kuvien luettelossa. Numerointi on globaali koko dokumentin läpi eikä nollaudu lukujen väliin. Koodilohkoon voi viitata label-viittauksella, esim. `@fibonacci`.

## Kummankin lohkotyypin yhteiset piirteet

- Vaaleanharmaa tausta.
- Syntaksiväritys `lang`-tunnisteen (esim. `python`) mukaan, Typstin oman `raw`-elementin kautta.
