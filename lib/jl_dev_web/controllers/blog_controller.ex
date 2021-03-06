defmodule JLDevWeb.BlogController do
  use JLDevWeb, :controller
  alias JLDev.Blog

  def index(conn, _params) do
    render(conn, "index.html", posts: Blog.all_posts())
  end

  def show(conn, %{"slug" => id}) do
    post = Blog.get_post(id)
    render(conn, "show.html", post: post)
  end

  def feed(conn, _) do
    feed = Blog.feed()

    conn
    |> put_resp_content_type("application/atom+xml")
    |> send_resp(200, feed)
  end
end
