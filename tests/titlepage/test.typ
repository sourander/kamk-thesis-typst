#import "/src/core/config.typ": setup-document
#import "/src/sections/titlepage.typ": titlepage

#let title = "Visual Regression for Title Page"
#let authors = ("Testaaja Tero",)
#let language = "fi"

// Apply base fonts and text settings
#show: setup-document.with(
  title: title,
  authors: authors,
  language: language
)

// Replicate the zero-margin wrapper from frontmatter.typ
#set page(margin: 0cm)

#titlepage(
  title: title,
  authors: authors,
  degree-title: "Testaaja (AMK)",
  degree-programme: "Testausohjelma",
  date: datetime(year: 2026, month: 1, day: 15),
  language: language,
  cover-image: none
)
