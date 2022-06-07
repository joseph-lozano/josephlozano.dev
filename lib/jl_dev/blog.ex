defmodule JLDev.Blog do
  alias JLDev.Blog.Post

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:jl_dev, "priv/posts/**/*.md"),
    as: :posts,
    parser: JLDev.Blog.Parser

  # The @posts variable is first defined by NimblePublisher.
  # Let's further modify it by sorting all posts by descending date.
  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  @posts_by_id @posts |> Enum.map(&{&1.id, &1}) |> Enum.into(%{})

  # Let's also get all tags
  @tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

  # And finally export them
  def all_posts, do: @posts
  def all_tags, do: @tags

  def get_post(id), do: @posts_by_id[id]
end
