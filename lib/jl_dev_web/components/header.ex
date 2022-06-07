defmodule JLDevWeb.Components.Header do
  use JLDevWeb, :component

  def header(assigns) do
    ~H"""
    <header class="flex justify-between items-center px-12">
      <div class="flex space-x-4 items-baseline">
        <%= link to: Routes.page_path(JLDevWeb.Endpoint, :index) do %>
          <div class="text-4xl py-5 font-black font-planet-benson-2 bg-gradient-to-t from-secondary-500 to-primary-500 bg-clip-text text-transparent hover:font-normal">
            {/}
          </div>
        <% end %>
        <%= link to: Routes.page_path(JLDevWeb.Endpoint, :index), class: "hidden md:inline" do %>
          <div class="text-3xl font-mono text-gray-700 hover:underline dark:text-gray-200">
            josephlozano.dev
          </div>
        <% end %>
      </div>
      <div class="flex space-x-4 items-baseline">
        <%= link to: "/blog" do %>
          <div class="text-xl font-mono text-gray-700 dark:text-gray-200 hover:underline">
            blog
          </div>
        <% end %>
        <a href="mailto:me@josephlozano.dev">
          <div class="text-xl font-mono text-gray-700 dark:text-gray-200 hover:underline">
            contact
          </div>
        </a>
      </div>
    </header>
    """
  end
end
