defmodule JLDevWeb.PageController do
  use JLDevWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
