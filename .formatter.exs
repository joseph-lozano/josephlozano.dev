[
  plugins: [Phoenix.LiveView.HTMLFormatter],
  import_deps: [:phoenix],
  inputs: ["*.{heex,ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{heex,ex,exs}"],
  locals_without_parens: [form_for: 3, form_for: 4, inputs_for: 3, inputs_for: 4]
]
