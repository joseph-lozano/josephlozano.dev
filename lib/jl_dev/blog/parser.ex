defmodule JLDev.Blog.Parser do
  def parse(_path, contents) do
    [frontmatter, body] = :binary.split(contents, ["\n---\n"])

    attrs =
      YamlElixir.read_from_string!(frontmatter)
      |> Enum.map(fn {key, value} -> {String.to_atom(key), value} end)
      |> Enum.into(%{})

    {attrs, body}
  end
end
