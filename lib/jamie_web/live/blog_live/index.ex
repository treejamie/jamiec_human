defmodule JamieWeb.BlogLive.Index do
  use JamieWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    socket =
      socket
      |> assign(:posts, Jamie.Blog.published_posts())

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <%= for post <- @posts do %>
        {post.title}
      <% end %>
    </Layouts.app>
    """
  end
end
