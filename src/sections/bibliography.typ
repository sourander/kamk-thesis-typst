// Load the translations
#let lang-data = toml("../data/lang.toml")

// `source` must be a resolved `path` value (e.g. path("references.bib")) built by the caller,
// since relative path strings resolve relative to the file where they are ultimately used.
#let render-bibliography(language: "fi", source: none, style: "ieee") = {
  let d = lang-data.at(language)

  bibliography(source, title: d.references_heading, style: "../data/kamk-vancouver.csl")
}
