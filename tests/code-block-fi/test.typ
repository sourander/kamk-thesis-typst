#import "/src/core/config.typ": setup-document, setup-body-page, code-block

#let language = "fi"

// Apply base fonts and text settings
#show: setup-document.with(
  title: "Does not matter here",
  authors: ("Not used here",),
  language: language
)

// Apply body-page geometry and heading styles
#show: setup-body-page.with(language: language)

= Testiluvun otsikko

Lyhyt koodilohko ei saa rivinumeroita eikä kuvatekstiä. Katso esimerkki alta (ks. @code-block-fi-summa).

#code-block(
  language: language,
  ```python
  def summa(a, b):
      return a + b
  ```
) <code-block-fi-summa>

Pitkä (vähintään 10 rivin) koodilohko saa rivinumerot ja vaatii kuvatekstin:

#code-block(
  caption: [Fibonaccin luvun laskeminen iteratiivisesti.],
  language: language,
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
) <code-block-fi-fibonacci>

Pitkään koodilohkoon voi viitata, esim. @code-block-fi-fibonacci.
