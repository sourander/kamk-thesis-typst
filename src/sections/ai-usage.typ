// Load the translations
#let lang-data = toml("../data/lang.toml")

// Template-generated AI-usage disclosure; only `tools` and `usage` are author-supplied.
#let render-ai-usage(language: "fi", tools: none, usage: none) = {
  let d = lang-data.at(language)

  heading(level: 1, outlined: true, numbering: none, d.ai_usage_title)

  d.ai_usage_intro

  v(1.5em)

  [*#d.ai_usage_tools_label:*]
  tools

  v(1.5em)

  [*#d.ai_usage_purpose_label:*]
  usage

  v(1.5em)

  d.ai_usage_declaration
}
