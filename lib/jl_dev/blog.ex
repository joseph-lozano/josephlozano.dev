defmodule JLDev.Blog do
  alias JLDev.Blog.Post
  alias Atomex.{Feed, Entry}

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

  date_to_time = fn date ->
    DateTime.new!(date, Time.new!(0, 0, 0))
  end

  get_entry = fn post ->
    [:id, :title, :body, :description, :tags, :date]

    Entry.new(
      "https://josephlozano.dev/blog/#{post.id}",
      date_to_time.(post.date),
      post.title
    )
    |> Entry.content(post.body, type: "html")
    |> Entry.build()
  end

  @feed Feed.new(
          "https://josephlozano.dev/blog/",
          date_to_time.(hd(@posts).date),
          "Personal blog of Joseph Lozano"
        )
        |> Feed.author("Joseph Lozano", email: "me@josephlozano.dev")
        |> Feed.link("https://josephlozano.dev/blog/feed", rel: "self")
        |> Feed.entries(Enum.map(@posts, &get_entry.(&1)))
        |> Feed.build()
        |> Atomex.generate_document()

  def feed() do
    @feed
  end
end
