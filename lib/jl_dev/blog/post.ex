defmodule JLDev.Blog.Post do
  @enforce_keys [:id, :title, :body, :description, :tags, :date]
  defstruct [:id, :title, :body, :description, :tags, :date]

  def build(filename, attrs, body) do
    [yearStr, file] =
      Path.split(filename)
      |> Enum.take(-2)

    [monthStr, dateStr, slug_md] = String.split(file, "-", parts: 3)
    [id, "md"] = String.split(slug_md, ".", parts: 2)

    [year, month, date] = Enum.map([yearStr, monthStr, dateStr], &String.to_integer(&1))

    %__MODULE__{
      id: id,
      title: attrs[:title] || raise("All posts must have a title"),
      body: body,
      description: attrs[:description],
      tags: attrs[:tags] || [],
      date: Date.new!(year, month, date)
    }
  end
end
