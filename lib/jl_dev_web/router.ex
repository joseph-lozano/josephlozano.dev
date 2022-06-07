defmodule JLDevWeb.Router do
  use JLDevWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {JLDevWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JLDevWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/blog", BlogController, :index
    get "/blog/:slug", BlogController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", JLDevWeb do
  #   pipe_through :api
  # end
end
