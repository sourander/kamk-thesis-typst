#import "/src/core/config.typ": setup-document, setup-body-page

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

// Notice how referencable short blocks are wrapped in an empty figure
#figure()[
  ```python
  def summa(a, b):
      return a + b
  ```
] <code-block-fi-summa>

Pitkä (vähintään 10 rivin) koodilohko saa rivinumerot ja vaatii kuvatekstin:

#figure(
caption: [Fibonaccin luvun laskeminen iteratiivisesti.],
)[
  ```python
  def fibonacci(n):
      if n <= 0:
          return []
      elif n == 1:
          return [0]
      elif n == 2:
          return [0, 1]
      else:
          fib = [0, 1]
          for i in range(2, n):
              next_fib = fib[i - 1] + fib[i - 2]
              fib.append(next_fib)
          return fib
  ```
] <code-block-fi-fibonacci>

Pitkään koodilohkoon voi viitata, esim. @code-block-fi-fibonacci.
